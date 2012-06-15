//= require jquery
//= require modernizr.custom
//= require jquery.tokeninput
//= require jquery.alphanumeric
//= require jquery_ujs
//= require bootstrap
//= require_self
//= require_tree ./common
//= require_tree ./admin
//= require ckeditor/init

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
    $("#lessondesc_pattern_catalog_tokens").tokenInput("/admin/catalogs.json", {
        crossDomain:false,
        preventDuplicates:true,
        prePopulate:$("#lessondesc_pattern_catalog_tokens").data("pre")
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
            $('#lesson_catalog_tokens').tokenInput("add", rss_catalog);
        } else {
            // Remove RSS categories to catalogs
            $('#lesson_catalog_tokens').tokenInput("remove", rss_catalog);
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
            success:function (data) {
                eval(data);
            }
        });

        e.preventDefault();
    });
}

// Batch operations
$(function () {
    // Check all
    $('#batch-all').click(function () {
        $(this).closest('table').find('.batch').prop('checked', $(this).prop('checked'));
    });

    // Perform action
    $('#batch-action').change(function () {
        action = $(this).val();
        if (action != '') {
            $('.batch:checked').each(function (index, element) {
                submit_action(action, element);
            });
        }
    });
})

function submit_action(action, element) {
    var $element = $(element);
    var form = $element.closest('form');
    var url = form.attr('action') + '/catalogs/' + container_id + '/batch';

    $element.siblings('img').show();

    $.getJSON(
        url,
        { batch_type: action }
    ).error(function (data) {
            alert('Error: Unable to ' + action + '@' + url + ': (' + data.statusText + ')');
        }).success(function (data) {
            if (data.ok) {
                $element.prop('checked', false);
            } else {
                alert('Error: Unable to ' + action + '@' + url + ': (' + data.msg + ')');
            }
        }).complete(function () {
            $element.siblings('img').hide();
        });
}
