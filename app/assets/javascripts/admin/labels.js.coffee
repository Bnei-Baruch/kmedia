# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  register_handlers();

register_handlers = () ->
  suid = $('input[name="label[suid]"]')
  if suid.length > 0
    on_success = (data) ->
      if data.length > 0
        $('#existing_suids').html(data.toString())
          .attr('class', 'alert alert-error')
      else
        $('#existing_suids').html(suid.val() + ' is free to use.')
          .attr('class', 'alert alert-success')

    suid.keyup (e) =>
      if suid.val().length > 2
        $.get('/admin/dictionaries/labels/existing_suids', 'suid=' + suid.val(), on_success, 'json')