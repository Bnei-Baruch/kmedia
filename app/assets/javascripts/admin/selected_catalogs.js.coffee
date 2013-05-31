$ -> new SelectedCatalogs

class SelectedCatalogs
  constructor: ->
    $('#catalog_catalognodename').autocomplete
      source: $('#catalog_catalognodename').data('autocomplete-source')
