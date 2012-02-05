//= require jquery_ujs
//= require bootstrap
//= require_self
//= require_tree ./common
//= require_tree ./admin

$(function () {
    $("#lesson_catalog_tokens").tokenInput("/admin/catalogs.json", {
        crossDomain:false,
        preventDuplicates:true,
        onAdd:function (item) {
            if (item.id == 3606 || item.id == 3661 || item.id == 3662) { // RSS
                $('#lesson_rss').attr('checked', true);
            }
        },
        onDelete:function (item) {
            if (item.id == 3606 || item.id == 3661 || item.id == 3662) { // RSS
                $('#lesson_rss').attr('checked', false);
            }
        },
        prePopulate:$("#lesson_catalog_tokens").data("pre")
    });
    $("#catalog_parentnodeid").tokenInput("/admin/catalogs.json", {
        crossDomain:false,
        preventDuplicates:true,
        tokenLimit:1,
        prePopulate:$("#catalog_parentnodeid").data("pre")
    });

    // Limit name of catalog to lowercase english letters and digits, '-'
    // Convert letters to lowercase; convert '_' and ' ' to '-'
    $("#catalog_catalognodename").alphanumeric({allow:"-_ "});
    $("#catalog_submit").click(function () {
        var text = $("#catalog_catalognodename").val();
        $("#catalog_catalognodename").val(text.replace(/[\s_]/g, '-').toLowerCase());
    });

    $('#lesson_rss').live('click', function () {
        if ($(this).is(':checked')) {
            // Add RSS categories to catalogs
        } else {
            // Remove RSS categories to catalogs
        }
    });

});

// We have to submit ID=0 for new lesson
function auto_parse() {
    $('a.auto-parse').live('click', function (e) {
        var element = $(this);
        var method, url, data, dataType;
        method = element.attr('data-method') || 'GET';
        url = element.attr('href');
        data = "name=" + $('#lesson_lessonname').val();
        dataType = element.attr('data-type') || ($.ajaxSettings && $.ajaxSettings.dataType);
        $.ajax({
            url:url, type:method, data:data, dataType:dataType,
            success: function(data) {
                eval(data);
            }
        });

        e.preventDefault();
    });
}