# frozen_string_literal: true

require 'gender_form_builder'

module ApplicationHelper
  def macro(partial, **vars, &block)
    if block_given?
      render layout: partial, locals: vars, &block
    else
      render partial: partial, locals: vars
    end
  end

  HOVER_ICO_TYPES = { warn: '!', info: '?', dict: '✱' }.freeze

  def hover_ico(type, &block)
    unless HOVER_ICO_TYPES.keys.include?(type)
      raise ArgumentError, "unknown type, must be one of #{HOVER_ICO_TYPES.keys}"
    end

    macro('hover_ico', type: type, &block)
  end

  BANNER_TYPES = {
    success: %w(✔ Success!),
    err:     %w(✖ Oops!),
    warn:    %w(! Warning!),
    info:    %w(? FYI...),
    timer:   %w(⌛ Tick-tock...)
  }.freeze

  def banner(type, &block)
    type = banner_devise_convert(type)

    unless BANNER_TYPES.keys.include?(type)
      raise ArgumentError, "unknown type, must be one of #{BANNER_TYPES.keys}"
    end

    macro(
      'custom_banner',
      type: type,
      ico: BANNER_TYPES[type][0],
      title: BANNER_TYPES[type][1],
      &block
    )
  end

  def user_handle(user, clan_sym = true)
    render 'user_handle', user: user, clan_sym: clan_sym
  end

  # Convert a datetime into the timezone of the current user, or UTC if none set/not logged in
  def local_timezone(datetime, default = 'UTC')
    tz = current_user&.timezone || default
    Time.at(datetime).in_time_zone(tz)
  end

  # short = 28-Mar-2017; long = 28 March 2017
  def friendly_date(datetime, long = true, local = true)
    datetime = local_timezone(datetime) if local
    long ? datetime.strftime('%d %B %Y') : datetime.strftime('%d-%b-%Y')
  end

  def friendly_datetime(datetime, long = true, local = true)
    datetime = local_timezone(datetime) if local
    friendly_date(datetime, long, false) + (long ? ',' : '') + datetime.strftime(' %H:%M')
  end

  # Returns a time tag with the appropriate CWS thingies so that our time
  # javascript can dynamically 'time'-ize it.
  #
  # @param [Time] time the time to display
  # @param [bool] with_time display with time?
  # @param [bool] long long format?
  # @param [bool] local local or server time?
  # @return [string] the rendered date macro
  def cws_time_tag(time = Time.now, with_time: true, long: true, local: true)
    time.utc
    fallback = send(:"friendly_date#{with_time ? 'time' : ''}", time, long, local)

    macro(
      'date',
      time: js_time_fmt(time, with_time: with_time),
      with_time: with_time,
      fallback: fallback,
      long: long,
      local: local
    )
  end

  # Same as #cws_time_tag, but uses shit like '1 hour ago', '32 minutes ago',
  # like #time_ago_in_words, and puts a title tag on the time tag with the
  # actual time, in the user's timezone.
  def cws_time_tag_relative(time = Time.now, local: true, include_seconds: true)
    time.utc

    macro(
      'date_ago',
      time: js_time_fmt(time),
      time_ago: time_ago_in_words(time, include_seconds: include_seconds),
      local: local
    )
  end

  # Transforms the route shorthand controller#action into a proper url.
  # @param [String] route the route in controller#action form
  # @return [String] the url
  def route_path(route)
    controller, action = route.split('#')
    url_for(action: action, controller: controller)
  end

  private

  BANNER_DEVISE_CORRL = {
    error:  :err,
    alert:  :err,
    notice: :info
  }.freeze

  def banner_devise_convert(type)
    BANNER_DEVISE_CORRL[type] || type
  end

  def js_time_fmt(time = Time.now, with_time: true)
    time.strftime("%Y-%m-%d#{'T%H:%M:%S' if with_time}")
  end
end
