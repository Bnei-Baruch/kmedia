$ ->
  # Register all links to send events
  # The following data- parameters are supported
  # -category (default: link)
  # -action (default: click)
  # -label (default: href)
  $('body a').on 'click', ->
    category = $(this).data('category') || 'link'
    action = $(this).data('action') || 'click'
    label = $(this).data('label') || $(this).prop('href')
    ga('send', 'event', {
      'eventCategory': category
      'eventAction': action
      'eventLabel': label
    })

