$(function() {
  var ti = $("#lesson_catalog_tokens").tokenInput("/admin/catalogs.json", {
    crossDomain: false,
    preventDuplicates: true,
    onAdd: function (item) {
      if (item.id == 3606 || item.id == 3661 || item.id == 3662) { // RSS
         $('#lesson_rss').attr('checked', true);
      }
    },
    onDelete: function (item) {
      if (item.id == 3606 || item.id == 3661 || item.id == 3662) { // RSS
         $('#lesson_rss').attr('checked', false);
      }
    },
    prePopulate: $("#lesson_catalog_tokens").data("pre")
  });
});

$('#lesson_rss').live('click', function(){
  if ($(this).is(':checked')) {
    // Add RSS categories to catalogs
    $('.token-input-input-token input').val('Video1');
    $.event.trigger({type:'keypress', which: 8});
  } else {
    // Remove RSS categories to catalogs
  }
});
