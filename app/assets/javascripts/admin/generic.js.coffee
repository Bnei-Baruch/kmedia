#  We have to submit ID=0 for new container
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
  $catalog_tokens = $("#container_catalog_tokens")
  $pattern_catalog_tokens = $("#container_description_pattern_catalog_tokens")
  $catalog_parent_id = $("#catalog_parent_id")
  $container_label_tokens = $("#container_label_tokens")
  $catalog_name = $("#catalog_name")
  $catalog_tokens.tokenInput "/admin/catalogs.json",
    minChars: 2
    crossDomain: false
    preventDuplicates: true
    onAdd: (item) ->
      # RSS
      $("#container_rss").attr "checked", true  if item.id is 3606 or item.id is 3661 or item.id is 3662
    onDelete: (item) ->
      # RSS
      $("#container_rss").attr "checked", false  if item.id is 3606 or item.id is 3661 or item.id is 3662
    prePopulate: $catalog_tokens.data("pre")
  $pattern_catalog_tokens.tokenInput "/admin/catalogs.json",
    minChars: 2
    crossDomain: false
    preventDuplicates: true
    prePopulate: $pattern_catalog_tokens.data("pre")
  $catalog_parent_id.tokenInput "/admin/catalogs.json",
    minChars: 2
    crossDomain: false
    preventDuplicates: true
    tokenLimit: 1
    prePopulate: $catalog_parent_id.data("pre")
  $container_label_tokens.tokenInput "/admin/dictionaries/labels/assignable.json",
    crossDomain: false
    preventDuplicates: true
    prePopulate: $container_label_tokens.data("pre")
  # Limit name of catalog to lowercase english letters and digits, '-'
  # Convert letters to lowercase; convert '_' and ' ' to '-'
  $catalog_name.alphanumeric allow: "-_ "
  $("#catalog_submit").click ->
    text = $catalog_name.val()
    $catalog_name.val text.replace(/[\s_]/g, "-").toLowerCase()
  $("#container_rss").on "click", ->
    if $(this).is(":checked")
      # Add RSS categories to catalogs
      $("#container_catalog_tokens").tokenInput "add", rss_catalog
    else
      # Remove RSS categories to catalogs
      $("#container_catalog_tokens").tokenInput "remove", rss_catalog
  # Check all
  $("#batch-all").click ->
    $(this).closest("table").find(".batch").prop "checked", $(this).prop("checked")
  # Perform action
  $("#batch-action").change ->
    action = $(this).val()
    if action isnt ""
      $(".batch:checked").each (index, element) ->
        submit_action action, element
