$ -> new MoveHelper

class MoveHelper
  constructor: ->
    $('.sortable_tree').on('click', '.move', @move_nodes)
    $('#move_prepare').on('click', '.batch-all', @move_select_all)
    $('#move_prepare').on('click', '.move', @move_containers)
    $('.vl-combine-selected').on('click', @combine_virtual_lessons)
    $('.lesson-combine-selected').on('click', @combine_selected_lessons)

  move_nodes: (event) ->
    element = $(this)
    href = element.prop('href')
    selected = $('.select:checked').map(->
      @value
    ).get().join()

    element.prop('href', href + '&sources=' + selected)
    true

  move_select_all: (event) ->
    $(this).closest('table').find('.batch').prop('checked', $(this).prop('checked'))

  # Move containers from specific catalog
  move_containers: (event) ->
    selected = $($(this).siblings('table').get(0)).find('.batch:checked').map(->
      @value
    ).get().join()

    $(this).prop('href', $(this).prop('href') + '&containers=' + selected)
    true

  ################################
  # virtual lessons
  combine_virtual_lessons: (event) ->
    vls = $('.virtual-lessons .selected:checked')
    if vls.length < 2
      e.preventDefault
      alert('Please select at least two VLs')
      return false

    film_date = $(vls.get(0)).parents('tr').find('.film-date').text()

    error = false
    $('.virtual-lessons .selected:checked').each(->
      if film_date != $(this).parents('tr').find('.film-date').text()
        e.preventDefault
        alert('All VLs have to belong to the same film_date')
        error = true
        return false
      return true
    )

    return false if error

    selected = $('.virtual-lessons .selected:checked').map(->
      @value
    ).get().join()
    $(this).prop('href', $(this).prop('href') + '?vls=' + selected)

    return true

  ################################
  # lessons
  combine_selected_lessons: (event) ->
    vls = $('.lessons .selected:checked')
    if vls.length < 2
      e.preventDefault
      alert('Please select at least two Containers')
      return false

    film_date = $(vls.get(0)).parents('tr').find('.created').text()

    error = false
    $('.lessons .selected:checked').each(->
      if film_date != $(this).parents('tr').find('.created').text()
        e.preventDefault
        alert('All Containers have to belong to the same "filmed" date')
        error = true
        return false # this will breake each()
      return true
    )

    return false if error

    selected = $('.lessons .selected:checked').map(->
      @value
    ).get().join()
    $(this).prop('href', $(this).prop('href') + '?containers=' + selected)

    return true
