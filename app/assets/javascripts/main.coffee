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

  $('.form_colour_select').minicolors({ inline: true });

  # Toggle disabled text field when unnamed language checked
  $('input#unnamed').change(->
    if $(this).is(':checked')
      $('.noname-dis-prop').prop('disabled', true).val('')
    else
      $('.noname-dis-prop').prop('disabled', false)
  )

  # Close alert
  $('.alert-close').click -> $(this).parent('.alert').fadeOut();

  # Allow only alphanumeric langcode
  $('#language_code').keypress (e) ->
    regex = new RegExp("^[a-zA-Z0-9]+$")
    str = String.fromCharCode(if !e.charCode then e.which else e.charCode)
    if regex.test(str)
      return true
    e.preventDefault()
    return false

  # Open/close sidebar things
  $('.side-button').click(->
    elem = $(this).children('.side-screen')
    if elem.is(':visible')
      elem.hide()
    else
      $('.side-screen').hide()
      elem.show()
  ).children('.side-screen').click ->
    return false

  $('.dropdown-menu a.dropdown-toggle').click ->
    if (!$(this).next().hasClass('show'))
      $(this).parents('.dropdown-menu').first().find('.show').removeClass("show")
    $subMenu = $(this).next(".dropdown-menu")
    $subMenu.toggleClass('show')

    $(this).parents('li.nav-item.dropdown.show').on('hidden.bs.dropdown', (e) ->
      $('.dropdown-submenu .show').removeClass("show")
    )

    return false

  # Make clan preview auto-update
  d_name = $('#preview_name')
  d_blob = $('#preview_blob')
  $('.form_colour_select').change ->
    d_name.css('color', $(this).val())
    d_blob.css('background', $(this).val())
  $('.preview_field_name').on 'change keyup paste', ->
    d_name.text($(this).val())
  $('.preview_field_symbol').on 'change keyup paste', ->
    d_blob.text($(this).val().substr(0,1))

)