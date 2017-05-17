add_trigger = (el, cntr) ->
  el.on('input', -> cntr.val("#{el.val().length}/#{cntr.data('cws-max')}"))

  el.trigger('input')

add_counter = (el, max) ->
  cntr = $("<input class='cntr' type='text' size='9' value='0/0' readonly data-cws-max='#{max}' />")
  cntr.insertAfter(el)

  return cntr

$(document).on("turbolinks:load", ->
  header_btns = $('.header_btn_home, .header_btn_lang')
  $('nav').stick_in_parent({ parent: 'body' })
    .on('sticky_kit:stick',   -> header_btns.addClass('is_shown'))
    .on('sticky_kit:unstick', -> header_btns.removeClass('is_shown'))

  $('textarea[data-cws-char-limit]').each ->
    el = $(this)
    cntr = add_counter(el, el.data('cws-char-limit'))
    add_trigger(el, cntr)

  $('#language_select').change (e) -> Turbolinks.visit(e.target.selectedOptions[0].dataset['path'])
)

