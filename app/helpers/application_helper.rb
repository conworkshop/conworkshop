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
    fmt = "%Y-%m-%d#{with_time ? 'T%H:%M:%S' : ''}"
    fallback = send(:"friendly_date#{with_time ? 'time' : ''}", time, long, local)

    macro(
      'date',
      time: time.strftime(fmt),
      with_time: with_time,
      fallback: fallback,
      long: long,
      local: local
    )
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
end
