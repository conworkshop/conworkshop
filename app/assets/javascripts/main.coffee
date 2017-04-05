class TimeManager
  constructor: (utz) ->
    @tz = @figureOutTz(utz)

  update: ->
    self = this
    $('time[datetime]').each ->
      el  = $(this)
      dt  = el.attr('datetime')
      fmt = self.getFormat(el.data('cws-time-with-time'), el.data('cws-time-long'))
      tz  = if self.isRubyTruthy(el.data('cws-time-local')) then self.tz else 'UTC'

      el.text(moment(dt, moment.ISO_8601).tz(tz).format(fmt))

# ----------- private -----------
  figureOutTz: (utz) ->
    return utz if utz && utz.length != 0

    moment.tz.guess()

  getFormat: (with_time, long) ->
    if long is ''
      'DD MMMM YYYY' + (if with_time is '' then ', HH:mm' else '')
    else
      'DD-MMM-YYYY' + (if with_time is '' then ' HH:mm' else '')

  isRubyTruthy: (value) -> value isnt undefined && value isnt null

time_manager = new TimeManager(window.cws_user_tzinfo)
$(document).on("turbolinks:load", -> time_manager.update())

