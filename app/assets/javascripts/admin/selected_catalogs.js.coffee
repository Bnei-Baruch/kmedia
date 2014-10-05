$ -> new SelectedCatalogs

class SelectedCatalogs
  constructor: ->
    $source = $('#catalog_name')
    unless $source.length == 0
      $source.autocomplete
        source: $source.data('autocomplete-source')
