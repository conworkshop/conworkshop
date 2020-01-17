# frozen_string_literal: true

require 'gender_form_builder'
require 'langtype_form_builder'
require 'clan_form_builder'
require 'word_class_form_builder'

module ApplicationHelper
  # @return [Language] the current language
  def current_language
    current_user&.current_lang
  end

  # @return [String] the current language's name
  def current_language_name
    current_language&.name || t('general.nolang')
  end

  def macro(partial, **vars, &block)
    if block_given?
      render layout: partial, locals: vars, &block
    else
      render partial: partial, locals: vars
    end
  end

  HOVER_ICO_TYPES = { warn: '!', info: '?', dict: '✱' }.freeze

  def hover_ico(type, str = nil, &block)
    unless HOVER_ICO_TYPES.keys.include?(type)
      raise ArgumentError, "unknown type, must be one of #{HOVER_ICO_TYPES.keys}"
    end

    unless str || block_given?
      raise ArgumentError, 'must pass a block or a string to use'
    end

    macro('hover_ico', type: type, str: str, &block)
  end

  BANNER_TYPES = {
    success: 'Success!',
    danger:  'Oops!',
    warning: 'Warning!',
    info:    'FYI...',
    dark:    '⏳ Tick-tock...'
  }.freeze

  def banner(type, str = nil, &block)
    type = banner_devise_convert(type)

    unless BANNER_TYPES.keys.include?(type)
      raise ArgumentError, "unknown type, must be one of #{BANNER_TYPES.keys}"
    end

    unless str || block_given?
      raise ArgumentError, 'must pass a block or a string to use'
    end

    macro(
      'custom_banner',
      str: str,
      type: type,
      title: BANNER_TYPES[type],
      &block
    )
  end

  def user_handle(user, clan_sym = true, track_sym = true)
    render 'user_handle', user: user, clan_sym: clan_sym, track_sym: track_sym
  end

  def lang_handle(lang, flag_thumb: true)
    render 'lang_handle', lang: lang, flag_thumb: flag_thumb
  end

  def cws_local_time(time = Time.current, options = nil)
    local_time(time, options ? options : :long)
  end

  def cws_local_date(time = Time.current, options = nil)
    local_time(time, options ? options : :long_notime)
  end

  # Transforms the route shorthand controller#action into a proper url.
  # @param [String] route the route in controller#action form
  # @return [String] the url
  def route_path(route)
    controller, action = route.split('#')
    url_for(action: action, controller: controller)
  end

  def language_select_options(path_has_locale: true, with_path: true, selected: nil)
    options = I18n.available_locales.each_with_object([]) do |locale, opts|
      opt = [I18n.t("language_names.#{locale}"), locale.to_s]

      if with_path
        path = if path_has_locale
                 request.fullpath.sub(%r{\A/.+?(?:/|/?\z)}, "/#{locale}/")
               else
                 "/#{locale}#{request.fullpath}"
               end
        opt << { 'data-path': path }
      end

      opts << opt
    end

    options_for_select(options, selected || I18n.locale.to_s)
  end

  def x_sampa_to_ipa(input: '')
    input_chars = input.split('')
    ipa_str = ''
    working_data = nil
    count = 0
    

    while count < input.length do
      c = input[count]
      found = false
      working_data = Phone.where('sampa LIKE ?', "#{c}%").to_a().sort_by{|x| x.sampa.length}.reverse!

      working_data.each do |p|
        if input[count..(count + p.sampa.length - 1)] == p.sampa
          ipa_str += p.ipa
          count += p.sampa.length
          found = true
          break
        end
      end

      if !found
        #it might be a diacritical mark, check again
        working_data = Diacritic.where('sampa LIKE ?', "#{c}%").to_a().sort_by{|x| x.sampa.length}.reverse!
        working_data.each do |q|
          if input[count..(count + q.sampa.length - 1)] == q.sampa
            ipa_str += q.ipa
            count += q.sampa.length
            found = true
            break
          end
        end
        #at this point, nothing was found, so we give up
        if !found
          ipa_str += c
          count += 1
        end
      end
    end
    
    ipa_str

  end

  private

  BANNER_DEVISE_CORRL = {
    timer:  :dark,
    error:  :danger,
    alert:  :warning,
    notice: :info
  }.freeze

  def banner_devise_convert(type)
    BANNER_DEVISE_CORRL[type] || type
  end
end
