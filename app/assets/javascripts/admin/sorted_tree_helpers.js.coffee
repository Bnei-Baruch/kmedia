$ -> new SortedTreeHelpers

class SortedTreeHelpers
  constructor: ->
    $('.tree-zipper').on('click', @zip)

  zip: (event) ->
    $subtree = $(this).parent().next();
    if $(this).hasClass('minus')
      $(this).removeClass('minus').addClass('plus')
      $subtree.hide()
    else if $(this).hasClass('plus')
      $(this).removeClass('plus').addClass('minus')
      $subtree.show()
