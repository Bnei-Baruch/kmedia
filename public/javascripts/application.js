$(function() {
  $("#lesson_catalog_tokens").tokenInput("/admin/catalogs.json", {
    crossDomain: false,
    prePopulate: $("#lesson_catalog_tokens").data("pre")
  });
});