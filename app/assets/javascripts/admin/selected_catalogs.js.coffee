$ ->
  $('#catalog_catalognodename').autocomplete
    source: $('#catalog_catalognodename').data('autocomplete-source')

$ ->
  $('.tree-zipper').on 'click', (event) ->
    $subtree = $(this).parent().next();
    if $(this).hasClass('minus')
      $(this).removeClass('minus').addClass('plus')
      $subtree.hide()
    else if $(this).hasClass('plus')
      $(this).removeClass('plus').addClass('minus')
      $subtree.show()
