$ ->
  register_handlers()

register_handlers = () ->
  $('.sortable_tree .move').on 'click', (e) ->
    element = $(this)
    href = element.prop('href')
    selected = $('.select:checked').map(->
      @value
    ).get().join()

    element.prop('href', href + '&sources=' + selected)
    true

  # Check-all box
  $('#move_prepare .batch-all').on 'click', (e) ->
    $(this).closest('table').find('.batch').prop('checked', $(this).prop('checked'))

  # Move containers from specific catalog
  $('#move_prepare .move').on 'click', (e) ->
    selected = $($(this).siblings('table').get(0)).find('.batch:checked').map(->
      @value
    ).get().join()


    $(this).prop('href', $(this).prop('href') + '&containers=' + selected)
    true