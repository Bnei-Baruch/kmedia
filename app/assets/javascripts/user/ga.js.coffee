$ -> new GA_Events

class GA_Events
  constructor: ->

    # Left sidebar - search functionality
    $('#sidebar').on 'click', '.clear-filters button', (event) ->
      new GoogleAnalytics(this, event).clear_filters()
    $('#sidebar').on 'click', '#dates_range', (event) ->
      new GoogleAnalytics(this, event).filter_daterange
    $('#sidebar').on 'click', '.content-type', (event) ->
      new GoogleAnalytics(this, event).filter_content_type()
    $('#sidebar').on 'click', '.media-type', (event) ->
      new GoogleAnalytics(this, event).filter_media_type()
    $('#sidebar').on 'click', '#language_ids', (event) ->
      new GoogleAnalytics(this, event).filter_language_ids()

    # UI language change
    $('#languages').on 'click', (event) ->
      new GoogleAnalytics(this, event).language_change()

    # Generic search form
    $('form#new_search').on 'submit', (event) ->
      new GoogleAnalytics(this, event).search_submit()

    # Any link - use data- attributes to submit specific category, action and label
    $('body').on 'click', 'a', (event) ->
      new GoogleAnalytics(this, event).click_on_link

    # Video block
    $('.lessons-list').on 'click', 'a.prev-lesson', (event) ->
      label = $(this).attr('href').split('/')[3]
      new GoogleAnalytics(this, event).register_event('prev-lesson', 'click', label)
    $('.lessons-list').on 'click', 'a.next-lesson', (event) ->
      label = $(this).attr('href').split('/')[3]
      new GoogleAnalytics(this, event).register_event('next-lesson', 'click', label)
    $('.lessons-list').on 'click', '.languages-bar a', (event) ->
      new GoogleAnalytics(this, event).register_event('language-tab', 'click', $(this).attr('href'))
    $('.lessons-list').on 'click', '.right-switch-link', (event) ->
      new GoogleAnalytics(this, event).register_event('audio-video', 'click', 'audio')
    $('.lessons-list').on 'click', '.left-switch-link', (event) ->
      new GoogleAnalytics(this, event).register_event('audio-video', 'click', 'video')
    $('.lessons-list .media-table a').on 'click', (event) ->
      new GoogleAnalytics(this, event).register_event('lesson-part', 'click', $(this).attr('href'))

    # Other updates
    $('.updated-media h3').on 'click', 'a', (event) ->
      new GoogleAnalytics(this, event).register_event('updated-media-display', 'click', $(this).text())
    $('.updated-media').on 'click', '.languages-bar a', (event) ->
      new GoogleAnalytics(this, event).register_event('updated-media-language-tab', 'click', $(this).attr('href'))
    $('.updated-media').on 'click', '.tab-content a', (event) ->
      new GoogleAnalytics(this, event).register_event('updated-media-table', 'click', $(this).attr('href'))

    # Search results
    $('.pagination').on 'click', 'a', (event) ->
      new GoogleAnalytics(this, event).register_event('search-result-pagination', 'click', $(this).text())
    $('.item-list').on 'click', 'h4 a', (event) ->
      new GoogleAnalytics(this, event).register_event('search-result-h4', 'click', $(this).attr('href').split('/')[3])
    $('.item-list').on 'click', '.languages-bar a', (event) ->
      new GoogleAnalytics(this, event).register_event('search-result-language-bar', 'click', $(this).attr('href'))
    $('.item-list').on 'click', '.tab-content a', (event) ->
      new GoogleAnalytics(this, event).register_event('search-result-download', 'click', $(this).attr('href'))

class GoogleAnalytics
  constructor: (obj, event) ->
    @obj = obj
    @event = event

  register_event: (category, action, label) =>
    ga('send', 'event', {
      'eventCategory': category
      'eventAction': action
      'eventLabel': label
    })

  click_on_link: ->
    category = $(this).data('category') || 'link'
    action = $(this).data('action') || 'click'
    label = $(this).data('label') || $(this).prop('href')
    this.register_event(category, action, label)

  search_submit: ->
    query = $('#search_query_string').val()
    content_types = $('#search_content_type_id').val()
    media_types = $('#search_media_type_id').val()
    search_date_type = $('#search_date_type').val()
    search_dates_range = $('#search_dates_range').val()
    search_language_ids = $('#search_language_ids').val()
    search_catalog_ids = $('#search_catalog_ids').val()
    query = "query=#{query}\ncontent_types=#{content_types}\nmedia_types=#{media_types}\nsearch_date_type=#{search_date_type}\nsearch_dates_range=#{search_dates_range}\nsearch_language_ids=#{search_language_ids}\nsearch_catalog_ids=#{search_catalog_ids}"
    this.register_event('search', 'submit', query)

  clear_filters: ->
    this.register_event( 'search filters', 'click', 'clear all')

  filter_daterange: ->
    this.register_event( 'search filters', 'click', 'daterange')

  filter_content_type: ->
    ct = $(@obj).find('i').attr('class').split('-')[2]
    this.register_event('search filters', 'click', "content-type: #{ct}")

  filter_media_type: ->
    ct = $(@obj).find('i').attr('class').split('-')[2]
    this.register_event('search filters', 'click', "media-type: #{ct}")

  filter_language_ids: ->
    this.register_event('search filters', 'click', "language: #{$(@obj).val()}")

  language_change: ->
    this.register_event('UI language change', 'click', $('#languages option:selected').text())

