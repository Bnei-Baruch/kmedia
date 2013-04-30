$ ->
  $('.sortable_tree .move').on 'click', (e) ->
    element = $(this)
    href = element.prop('href')
    selected = $('.select:checked').map(->
      @value
    ).get().join()

    element.prop('href', href + '&sources=' + selected)
    true

$ ->
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


  ################################
  # virtual lessons
$ ->
  $('.vl-combine-selected').on 'click', (e) ->
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
$ ->
  $('.lesson-combine-selected').on 'click', (e) ->
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
        return false
      return true
    )

    return false if error

    selected = $('.lessons .selected:checked').map(->
      @value
    ).get().join()
    $(this).prop('href', $(this).prop('href') + '?containers=' + selected)

    return true
