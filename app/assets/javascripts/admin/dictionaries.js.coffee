# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  register_handlers()

register_handlers = () ->
  suid = $('input[name="dictionary[suid]"]')
  if suid.length
    suid_handlers(suid, '/admin/dictionaries/existing_suids')
  else
    suid = $('input[name="label[suid]"]')
    suid_handlers(suid, '/admin/dictionaries/labels/existing_suids') if suid.length


suid_handlers = (suid, url) ->
  on_success = (data) ->
    if data.length
      $('#existing_suids').html(data.toString()).attr('class', 'alert alert-error')
    else
      $('#existing_suids').html(suid.val() + ' is free to use.').attr('class', 'alert alert-success')

  suid.keyup (e) =>
    if suid.val().length > 2
      $.get(url, 'suid=' + suid.val(), on_success, 'json')
