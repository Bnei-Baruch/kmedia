#  We have to submit ID=0 for new lesson
auto_parse = ->
  $("a.auto-parse").on "click", (e) ->
    element = $(this)
    method = undefined
    url = undefined
    data = undefined
    dataType = undefined
    method = element.attr("data-method") or "GET"
    url = element.attr("href")
    data = "name=" + $("#lesson_lessonname").val()
    dataType = element.attr("data-type") or ($.ajaxSettings and $.ajaxSettings.dataType)
    $.ajax
      url: url
      type: method
      data: data
      dataType: dataType
      success: (data) ->
        eval data
    e.preventDefault()

submit_action = (action, element) ->
  $element = $(element)
  form = $element.closest("form")
  url = form.attr("action") + "/catalogs/" + container_id + "/batch"
  $element.siblings("img").show()
  $.getJSON(
    url
    batch_type: action
  ).error((data) ->
    alert "Error: Unable to " + action + "@" + url + ": (" + data.statusText + ")"
  ).success((data) ->
    if data.ok
      $element.prop "checked", false
    else
      alert "Error: Unable to " + action + "@" + url + ": (" + data.msg + ")"
  ).complete ->
    $element.siblings("img").hide()

$ ->
  $catalog_tokens = $("#lesson_catalog_tokens")
  $pattern_catalog_tokens = $("#lessondesc_pattern_catalog_tokens")
  $catalog_parentnodeid = $("#catalog_parentnodeid")
  $lesson_label_tokens = $("#lesson_label_tokens")
  $catalog_catalognodename = $("#catalog_catalognodename")
  $catalog_tokens.tokenInput "/admin/catalogs.json",
    minChars: 2
    crossDomain: false
    preventDuplicates: true
    onAdd: (item) ->
      # RSS
      $("#lesson_rss").attr "checked", true  if item.id is 3606 or item.id is 3661 or item.id is 3662
    onDelete: (item) ->
      # RSS
      $("#lesson_rss").attr "checked", false  if item.id is 3606 or item.id is 3661 or item.id is 3662
    prePopulate: $catalog_tokens.data("pre")
  $pattern_catalog_tokens.tokenInput "/admin/catalogs.json",
    minChars: 2
    crossDomain: false
    preventDuplicates: true
    prePopulate: $pattern_catalog_tokens.data("pre")
  $catalog_parentnodeid.tokenInput "/admin/catalogs.json",
    minChars: 2
    crossDomain: false
    preventDuplicates: true
    tokenLimit: 1
    prePopulate: $catalog_parentnodeid.data("pre")
  $lesson_label_tokens.tokenInput "/admin/dictionaries/labels/assignable.json",
    crossDomain: false
    preventDuplicates: true
    prePopulate: $lesson_label_tokens.data("pre")
  # Limit name of catalog to lowercase english letters and digits, '-'
  # Convert letters to lowercase; convert '_' and ' ' to '-'
  $catalog_catalognodename.alphanumeric allow: "-_ "
  $("#catalog_submit").click ->
    text = $catalog_catalognodename.val()
    $catalog_catalognodename.val text.replace(/[\s_]/g, "-").toLowerCase()
  $("#lesson_rss").on "click", ->
    if $(this).is(":checked")
      # Add RSS categories to catalogs
      $("#lesson_catalog_tokens").tokenInput "add", rss_catalog
    else
      # Remove RSS categories to catalogs
      $("#lesson_catalog_tokens").tokenInput "remove", rss_catalog
  auto_parse()
  # Check all
  $("#batch-all").click ->
    $(this).closest("table").find(".batch").prop "checked", $(this).prop("checked")
  # Perform action
  $("#batch-action").change ->
    action = $(this).val()
    if action isnt ""
      $(".batch:checked").each (index, element) ->
        submit_action action, element
