class TimeManager
  constructor: (utz) ->
    @tz = @figureOutTz(utz)

  update: ->
    self = this
    $('time[datetime]').each ->
      el  = $(this)
      dt  = el.attr('datetime')

      if self.isRubyTruthy(el.data('cws-time-title'))
        self.updateTitled(el, dt)
      else
        self.updateNormal(el, dt)

# ----------- private -----------
  updateNormal: (el, dt) ->
    fmt = @getFormat(el.data('cws-time-with-time'), el.data('cws-time-long'))
    tz  = @selectTz(el.data('cws-time-local'))

    el.text(moment.utc(dt, moment.ISO_8601).tz(tz).format(fmt))

  updateTitled: (el, dt) ->
    fmt = @getFormat(true, true)
    tz  = @selectTz(el.data('cws-time-local'))

    el.attr('title', moment.utc(dt, moment.ISO_8601).tz(tz).format(fmt))

  selectTz: (local) ->
    if @isRubyTruthy(local) then @tz else 'UTC'

  figureOutTz: (utz) ->
    return utz if @isRubyTruthy(utz) && utz.length != 0

    moment.tz.guess()

  getFormat: (with_time, long) ->
    if @isRubyTruthy(long)
      'DD MMMM YYYY' + (if @isRubyTruthy(with_time) then ', HH:mm' else '')
    else
      'DD-MMM-YYYY' + (if @isRubyTruthy(with_time) then ' HH:mm' else '')

  isRubyTruthy: (value) -> value isnt undefined && value isnt null

time_manager = new TimeManager(window.cws_user_tzinfo)

add_trigger = (el, cntr) ->
  el.on('input', -> cntr.val("#{el.val().length}/#{cntr.data('cws-max')}"))

  el.trigger('input')

add_counter = (el, max) ->
  cntr = $("<input class='cntr' type='text' size='9' value='0/0' readonly data-cws-max='#{max}' />")
  cntr.insertAfter(el)

  return cntr

$(document).on("turbolinks:load", ->
  time_manager.update()

  header_btns = $('.header_btn_home, .header_btn_lang')
  $('nav').stick_in_parent({ parent: 'body' })
    .on('sticky_kit:stick',   -> header_btns.addClass('is_shown'))
    .on('sticky_kit:unstick', -> header_btns.removeClass('is_shown'))

  $('textarea[data-cws-char-limit]').each ->
    el = $(this)
    cntr = add_counter(el, el.data('cws-char-limit'))
    add_trigger(el, cntr)
)

