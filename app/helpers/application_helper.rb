# frozen_string_literal: true

module ApplicationHelper
  # TODO: remove this
  def path_for(a, _b = {})
    "##{a}"
  end

  def macro(partial, **vars, &block)
    if block_given?
      render layout: partial, locals: vars, &block
    else
      render partial: partial, locals: vars
    end
  end

  HOVER_ICO_TYPES = { warn: '!', info: '?', dict: '✱' }.freeze

  def hover_ico(type, &block)
    macro('hover_ico', type: type, &block)
  end

  BANNER_TYPES    = {
    success: %w(✔ Success!),
    err:     %w(✖ Oops!),
    warn:    %w(! Warning!),
    info:    %w(? FYI...),
    timer:   %w(⌛ Tick-tock...)
  }.freeze

  def banner(type, &block)
    macro(
      'custom_banner',
      type: type,
      ico: BANNER_TYPES[type][0],
      title: BANNER_TYPES[type][1],
      &block
    )
  end
end
