//= require jquery
//= require modernizr.custom
//= require jquery_ujs
//= require_tree ./common
//= require_tree ./user

//=require bootstrap

//= require_tree ../../../lib/assets/javascripts/daterange
//= require jquery.zclip.min
//= require_self

$(document).ready(function () {

    //Close popups
    $('.close-popup').click(function () {
        $(this).parents('.popup').css('display', 'none');
    });

    //Categories Popup
    $('#content .navbar-inner li').on('click', function () {
        $('#content .navbar-inner li').removeClass('active');
        $('.category-modal').modal('hide');
        $(this).addClass('active');
    });
    $('.category-modal').on('hidden', function () {
        $('#content .navbar-inner li').removeClass('active');
    });
    $('.categories a').on('click', function () {
        var current_column = $(this).parents('.categories');
        var current_links = current_column.find('a');
        var item_index = current_links.index(this);
        var list_to_open = $('.categories').eq(current_column.index() + 1);

        $('.categories').each(function (index) {
            if ($(this).index() > current_column.index() + 1) {
                $(this).css('display', 'none');
            }
            if ($(this).index() >= current_column.index()) {
                $(this).find('.selected').removeClass('selected');
            }

        });
        $(this).parent().addClass('selected');
        list_to_open.css('display', 'block').scrollTop(0);
        list_to_open.children('ul').css('display', 'none').eq(item_index).css('display', 'block');

    });

    $('.show-tooltip').tooltip();

    $('.toggle .switch').click(function () {
        $('.toggle .switch div').toggleClass('left right');
        $('.toggle .switch div i').toggleClass('icon-km-small-white-video icon-km-small-white-audio');
    });
    $('.toggle .left-switch-link').click(function () {
        $('.toggle .switch div').removeClass('right').addClass('left');
        $('.toggle .switch div i').removeClass('icon-km-small-white-audio').addClass('icon-km-small-white-video');
    });
    $('.toggle .right-switch-link').click(function () {
        $('.toggle .switch div').removeClass('left').addClass('right');
        $('.toggle .switch div i').removeClass('icon-km-small-white-video').addClass('icon-km-small-white-audio');
    });

});

// search page support
function content_type(type) {
    $('#search_content_type_id').val(type);
    $('#new_search').submit();

    return false;
}

function media_type(type) {
    $('#search_media_type_id').val(type);
    $('#new_search').submit();

    return false;
}

function language_search(){
    $('#search_language_ids').val($('#language_ids').val());
    $('#new_search').submit();
}

function date_type(start, end) {
    if (start.getFullYear() == 1000) {
        $('.daterange').html('Anytime');
        $('#search_date_type').val('anytime');
    } else if (start.valueOf() == end.valueOf()) {
        $('.daterange').html(start.toString('MMMM d, yyyy'));
        $('#search_date_type').val('one_day');
    } else {
        $('.daterange').html(start.toString('MMMM d, yyyy') + '<br/><i class="icon-km-all"></i> ' + end.toString('MMMM d, yyyy'));
        $('#search_date_type').val('range');
    }

    $('#search_dates_range').val($('.daterange').html());
    $('#new_search').submit();

    return false;
}

function bind_zero_clipboard() {
    $('a.clipboard').zclip({
        path: '/ZeroClipboard.swf',
        clickAfter: false,
        copy: function () {
            return $(this).attr('href');
        }
    });
}
$(document).ready(function () {
    $('#dates_range').daterangepicker({
        opens: (typeof opens_dates_range == 'undefined') ? '' : opens_dates_range,
        format: 'yyyy-MM-dd',
        locale: (typeof locale_dates_range == 'undefined') ? '' : locale_dates_range,
        ranges: {
            'Anytime': ['1000', '3000'],
            'Today': ['today', 'today'],
            'Yesterday': ['yesterday', 'yesterday'],
            'Last 7 Days': [Date.today().add({ days: -6 }), 'today'],
            'Last 30 Days': [Date.today().add({ days: -29 }), 'today'],
            'This Month': [Date.today().moveToFirstDayOfMonth(), Date.today().moveToLastDayOfMonth()],
            'Last Month': [Date.today().moveToFirstDayOfMonth().add({ months: -1 }), Date.today().moveToFirstDayOfMonth().add({ days: -1 })]
        }
    }, function (start, end) {
        date_type(start, end);
    });

    if ($('.daterange').html() == '') {
        $('.daterange').html('Anytime');
    }

    bind_zero_clipboard();

    $('.languages-bar a[data-toggle="tab"]').on('shown', function (e) {
        bind_zero_clipboard();
    });

    $('#language_ids').change(language_search);
});
