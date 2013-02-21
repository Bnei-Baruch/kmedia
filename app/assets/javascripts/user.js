//= require jquery
//= require jquery_ujs
//= require_tree ./common
//= require_tree ./user

//=require bootstrap

//= require_tree ../../../lib/assets/javascripts/daterange
//= require jquery.zclip.min
//= require projekktor.min

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
        $('.toggle .switch div').trigger('video-audio');
    });
    $('.toggle .left-switch-link').click(function () {
        $('.toggle .switch div').removeClass('right').addClass('left');
        $('.toggle .switch div i').removeClass('icon-km-small-white-audio').addClass('icon-km-small-white-video');
        $('.toggle .switch div').trigger('video-audio');
    });
    $('.toggle .right-switch-link').click(function () {
        $('.toggle .switch div').removeClass('left').addClass('right');
        $('.toggle .switch div i').removeClass('icon-km-small-white-video').addClass('icon-km-small-white-audio');
        $('.toggle .switch div').trigger('video-audio');
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

function language_search() {
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

// projekktor

var projekktor_instance = null;

function stop_projekktor() {
    projekktor_instance.removeListener('item', nextFileStarted);

    projekktor_instance.selfDestruct();
    projekktor_instance = null;
}

function start_projekktor() {
    // Start projekktor on active tab-pane only
    projekktor_instance = projekktor('.active.tab-pane .projekktor', {
        plugins: ['display', 'controlbar'],
        platforms: ['flash', 'browser', 'ios', 'native'],
        autoplay: false,
        controls: true,
        volume: 0.5,
        height: 280,
        width: 370,
        minHeight: 280,
        minWidth: 370,
        forceFullViewport: true,
        poster: '/assets/cover-video.jpg',
        cover: '/assets/cover-video.jpg',
        playerFlashMP4: '/assets/jarisplayer.swf',
        playerFlashMP3: '/assets/jarisplayer.swf',
        messages: {
            // general
            0: 'An error occurred.',
            1: 'You aborted the media playback. ',
            2: 'A network error caused the media download to fail part-way. ',
            3: 'The media playback was aborted due to a corruption problem. ',
            4: 'The media (%{title}) could not be loaded because the server or network failed.',
            5: 'Sorry, your browser does not support the media format of the requested file.',
            6: 'Your client is in lack of the Flash Plugin V%{flashver} or higher.',
            7: 'No media scheduled.',
            8: '! Invalid media model configured !',
            9: 'File (%{file}) not found.',
            10: 'Invalid or missing quality settings for %{title}.',
            11: 'Invalid streamType and/or streamServer settings for %{title}.',
            12: 'Invalid or inconsistent quality setup for %{title}.',
            80: 'The requested file does not exist or delivered with an invalid content-type.',
            97: 'No media scheduled.',
            98: 'Invalid or malformed playlist data!',
            99: 'Click display to proceed. ',
            100: 'PLACEHOLDER',
            // Youtube errors
            500: 'This Youtube video has been removed or set to private',
            501: 'The Youtube user owning this video disabled embedding.',
            502: 'Invalid Youtube Video-Id specified.'
        }
    });
    projekktor('.active.tab-pane .projekktor').addListener('item', nextFileStarted);
    setup_projekktor_playlist('video');
    $('.active.tab-pane .projekktor').siblings('.btn-toolbar').find('.btn.btn-mini').first().addClass('active');
}

// type: 'audio' or 'video'
function setup_projekktor_playlist(type) {
    var players = $.grep($('.active.tab-pane .projekktor').attr('class').split(' '), function (n) {
        return n.match('video-')
    });
    $.each(players, function (index, player) {
        var lang = player.split('video-')[1];
        projekktor_instance.setFile(eval('playlist_' + lang + '_' + type));
    });
}

// mark a button as active
function nextFileStarted(itemIndex) {
    $('.active.tab-pane .projekktor').siblings('.btn-toolbar').find('.btn.btn-mini').removeClass('active');
    $($('.active.tab-pane .projekktor').siblings('.btn-toolbar').find('.btn.btn-mini')[itemIndex]).addClass('active');
}

// change projekktor to another tab
// just before show
$('.languages-bar a[data-toggle="tab"]').on('show', function (e) {
    var active = e.target; // activated tab
    var prev = e.relatedTarget; // previous tab

    if (projekktor_instance) {
        stop_projekktor();
    }
});
// immediately after show
$('.languages-bar a[data-toggle="tab"]').on('shown', function (e) {
    var active = e.target; // activated tab
    var prev = e.relatedTarget; // previous tab

    if (projekktor_instance) {
        stop_projekktor();
    }

    start_projekktor();
});

$('.active.tab-pane .btn[data-item-index]').on('click', function() {
    projekktor_play($(this).data('item-index'));
});

$('.toggle .switch div').on('video-audio', function() {
    var klass = $(this).attr('class');
    if (klass.indexOf('left') > 0) {
        setup_projekktor_playlist('video');
    } else {
        setup_projekktor_playlist('audio');
    }
});

function projekktor_play(itemno) {
    if (projekktor_instance) {
        projekktor_instance.setActiveItem(itemno);
        projekktor_instance.setPlay();
    }
}

$(document).ready(function () {
    start_projekktor();
});
