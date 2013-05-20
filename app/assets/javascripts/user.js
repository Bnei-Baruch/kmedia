//= require jquery_ujs
//= require_tree ./common
//= require_tree ./user

//=require bootstrap

//= require_tree ../../../lib/assets/javascripts/daterange
//= require jquery.zclip.min
//= require projekktor.min
//= require jquery.navobile.min

//= require_self

(function () {
    "use strict";

    function validateEmail(email) {
        var at, local, domain;

        at = email.lastIndexOf("@");

        // Make sure the at (@) sybmol exists and
        // it is not the first or last character
        if (at < 1 || (at + 1) === email.length) {
            return false;
        }

        // Make sure there aren't multiple periods together
        if (/(\.{2,})/.test(email)) {
            return false;
        }

        // Break up the local and domain portions
        local = email.substring(0, at);
        domain = email.substring(at + 1);

        // Check lengths
        if (local.length < 1 || local.length > 64 || domain.length < 4 || domain.length > 255) {
            return false;
        }

        // Make sure local and domain don't start with or end with a period
        if (/(^\.|\.$)/.test(local) || /(^\.|\.$)/.test(domain)) {
            return false;
        }

        // Check for quoted-string addresses
        // Since almost anything is allowed in a quoted-string address,
        // we're just going to let them go through
        if (!/^"(.+)"$/.test(local)) {
            // It's a dot-string address...check for valid characters
            if (!/^[\-a-zA-Z0-9!#$%*\/?|\^\\{\\}`~&'+=_\\.]*$/.test(local)) {
                return false;
            }
        }

        // Make sure domain contains only valid characters and at least one period
        if (!/^[\-a-zA-Z0-9\.]*$/.test(domain) || domain.indexOf(".") === -1) {
            return false;
        }

        return true;
    }

    $(document).ready(function () {
        //Categories Popup
        $('#content .navbar-inner li').on('click', function () {
            // Follow final links
            if ($(this).children().data('has-children') === 'leaf') {
                var id = $(this).children('a').data('node-id');

                // Catalog resets all other searches
                $('#new_search input').val('');
                $('#search_catalog_ids').val(id);
                $('#new_search').submit();
                return;
            }

            $('#content .navbar-inner li').removeClass('active');
            try {
                $('.category-modal').modal('hide');
            } catch (err) {
            }
            $(this).addClass('active');
        });
        $('#content .category-modal').on('hide', function () {
            $('#content .navbar-inner li').removeClass('active');
        });
        $('.modal-body').on('click', '.categories a', function () {
            var id = $(this).data('node-id'),
                tree = all_tree[id],
                html = '<div class="categories column2"><ul>',
                children,
                children_str,
                width,
                value;

            // Follow final links
            if (!$(this).data('has-children')) {
                // Catalog resets all other searches
                $('#new_search input').val('');
                $('#search_catalog_ids').val(id);
                $('#new_search').submit();
                return;
            }

            // Unselect current selected
            $(this).closest('ul').find('li').removeClass('selected');

            // Add new selected
            $(this).parent().addClass('selected');

            // Remove every box to the right of the current one
            $(this).closest('.categories').nextAll().remove();

            // Build new ul
            $.each(tree, function (key, value) {
                var name = value.catalognodename;
                try {
                    children = all_tree[value.catalognodeid].length;
                } catch (err) {
                    children = 0;
                }
                children_str = children > 0 ? ' <span class="children-amount">(' + children + ')</span> <span class="expander"></span>' : '';
                html += '<li><a href="javascript:;" data-has-children="' + (children > 0) + '" data-node-id="' + value.catalognodeid + '">' + name + children_str + '</a></li>';
            });
            html += '</ul></div>';

            // Draw next box to the right
            $(this).closest('.modal-body .categories-holder').append(html);
            $(this).closest('.modal-body').find('.categories').css('display', 'inline-block');
            $(this).closest('.modal-body').find('.categories ul').css('display', 'block');

            width = 0;
            $(this).closest('.modal-body .categories-holder').find('.categories').each(function () {
                width += $(this).outerWidth(true);
            });
            value = $('body').hasClass('rtl') ? 0 : width;
            $(this).closest('.categories-holder').animate({scrollLeft: value}, 800);
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

        $('#languages').change(function () {
            window.location = $(this).val();
        });

        // search page support
        $('a.content-type').on('click', function (e) {
            var type = $(this).data('content-type');

            e.preventDefault();

            $('#search_content_type_id').val(type);
            $('#new_search').submit();
        });

        $('a.media-type').on('click', function (e) {
            var type = $(this).data('media-type');

            e.preventDefault();

            $('#search_media_type_id').val(type);
            $('#new_search').submit();
        });

        $('#language_ids').on('change', function (e) {
            e.preventDefault();

            $('#search_language_ids').val($('#language_ids').val());
            $('#new_search').submit();
        });
    });

    function date_type(start, end) {
        if (start !== null) {
            if (start.getFullYear() === 1000) {
                $('.daterange').html(anytime);
                $('#search_date_type').val('anytime');
            } else if (start.valueOf() === end.valueOf()) {
                $('.daterange').html(start.toString('MMMM d, yyyy'));
                $('#search_date_type').val('one_day');
            } else {
                $('.daterange').html(start.toString('MMMM d, yyyy') + '<br/><i class="icon-km-all"></i> ' + end.toString('MMMM d, yyyy'));
                $('#search_date_type').val('range');
            }
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
            opens: (opens_dates_range === 'undefined') ? '' : opens_dates_range,
            format: 'yyyy-MM-dd',
            locale: (locale_dates_range === 'undefined') ? '' : locale_dates_range,
            ranges: open_dates_ranges
        }, function (start, end) {
            date_type(start, end);
        });

        if ($('.daterange').html() === '') {
            $('.daterange').html(anytime);
        }

        bind_zero_clipboard();

        $('.languages-bar a[data-toggle="tab"]').on('shown', function (e) {
            bind_zero_clipboard();
        });

        $('.clear-filters button').on('click', function () {
            $('#new_search input').val('');
            $('#new_search').submit();
        });

        $('#submit_comment').click(function () {
            var email, data, url;

            $('.alert').hide().html('&nbsp;');

            if ($('#new_comment #comment_name').val() === '') {
                $('.alert').html("Please fill in field 'Name'").show();
                return false;
            }
            if ($('#new_comment #comment_subject').val() === '') {
                $('.alert').html("Please fill in field 'Subject'").show();
                return false;
            }
            email = $('#new_comment #comment_email').val();
            if (email === '') {
                $('.alert').html("Please fill in field 'Email'").show();
                return false;
            }
            if (!validateEmail(email)) {
                $('.alert').html("Wrong email").show();
                return false;
            }
            if ($('#new_comment #comment_comment').val() === '') {
                $('.alert').html("Please fill in field 'Comment'").show();
                return false;
            }

            data = $('form#new_comment').serialize();
            url = $('form#new_comment').attr('action');

            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: 'JSON'
            })
                .done(function (json) {
                    alert(json.text);
                    $('#leave-comment').modal('hide');
                })
                .fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });

            return false;
        });

        $('#sidebar').navobile({
            cta: '.left-menu',
            content: '#content'
        });
        $('#categories-menu').navobile({
            cta: '.right-menu',
            content: '#content'
        });
    });
}());

// projekktor
(function () {
    "use strict";

    var projekktor_instance = null;

    // mark a button as active
    function nextFileStarted(itemIndex) {
        $('.active.tab-pane .projekktor').siblings('.btn-toolbar').find('.btn.btn-mini').removeClass('active');
        $($('.active.tab-pane .projekktor').siblings('.btn-toolbar').find('.btn.btn-mini')[itemIndex]).addClass('active');
    }

    // type: 'audio' or 'video'
    function setup_projekktor_playlist(type) {
        var players = $.grep($('.active.tab-pane .projekktor').attr('class').split(' '), function (n) {
            return n.match('video-');
        });
        $.each(players, function (index, player) {
            var lang = player.split('video-')[1];
            projekktor_instance.setFile(eval('playlist_' + lang + '_' + type));
        });
    }

    function projekktor_play(itemno) {
        if (projekktor_instance) {
            projekktor_instance.setActiveItem(itemno);
            projekktor_instance.setPlay();
        }
    }

    function stop_projekktor() {
        projekktor_instance.removeListener('item', nextFileStarted);

        projekktor_instance.selfDestruct();
        projekktor_instance = null;
    }

    function start_projekktor() {
        // Start projekktor on active tab-pane only
        if ($('.active.tab-pane .projekktor').length === 0) {
            return;
        }

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
            messages: projekktor_messages
        });
        projekktor('.active.tab-pane .projekktor').addListener('item', nextFileStarted);
        setup_projekktor_playlist('video');
        $('.active.tab-pane .projekktor').siblings('.btn-toolbar').find('.btn.btn-mini').first().addClass('active');
    }

    // change projekktor to another tab
    // just before show
    $('.lessons-list .languages-bar a[data-toggle="tab"]').on('show', function (e) {
        var active, prev;

        active = e.target; // activated tab
        prev = e.relatedTarget; // previous tab

        if (projekktor_instance) {
            stop_projekktor();
        }
    });

    // immediately after show
    $('.lessons-list .languages-bar a[data-toggle="tab"]').on('shown', function (e) {
        var active, prev;

        active = e.target; // activated tab
        prev = e.relatedTarget; // previous tab

        if (projekktor_instance) {
            stop_projekktor();
        }

        start_projekktor();
    });

    $('.active.tab-pane .btn[data-item-index]').on('click', function () {
        projekktor_play($(this).data('item-index'));
    });

    $('.toggle .switch div').on('video-audio', function () {
        var klass = $(this).attr('class');
        if (klass.indexOf('left') > 0) {
            setup_projekktor_playlist('video');
        } else {
            setup_projekktor_playlist('audio');
        }
    });

    $(document).ready(function () {
        start_projekktor();
    });

}());
