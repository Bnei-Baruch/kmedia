//= require jquery_ujs
//= require_tree ./common
//zzz= require_tree ./user

// We removed the bootstrap-scrollspy because it caused a bug of setting dropdown tab active after scroll
//= require bootstrap-transition
//= require bootstrap-alert
//= require bootstrap-button
//= require bootstrap-collapse
//= require bootstrap-dropdown
//= require bootstrap-modal
//= require bootstrap-tab
//= require bootstrap-tooltip

//= require_tree ../../../lib/assets/javascripts/daterange
//= require jquery.zclip.min
//= require projekktor.min
//= require iscroll
//= require jquery-ui-1.10.4.datepicker

//= require_self

(function () {
    "use strict";

    $(document).on('click', '.books-catalog a.books-expander', function () {
        var $this = $(this), $parent = $this.parent('li');
        $parent.toggleClass('expand');
    });

    var myScroll = null;

    Modernizr.load([
        //first test need for polyfill
        {
            test: window.matchMedia,
            nope: "/assets/media.match.min.js"
        },

        //and then load enquire
        {
            load: "/assets/enquire.min.js",
            complete: function () {
                enquire.register("screen and (max-width: 767px)", {
                    match: function () {
                        $('body').prepend('<div id="left-mobile-menu" class="left-mobile-menu"><div id="left-menu-wrapper"></div></div>');
                        $('#left-menu-wrapper')
                            .append('<h4>' + $('.top-menu-div .languages').data('title') + '</h4>')
                            .append($('.top-menu-div .languages'))
                            .append('<h4>' + $('.top-menu-div form').data('title') + '</h4>')
                            .append($('.top-menu-div form'))
//                            .append('<h4>' + $('#categories-menu').data('title') + '</h4>')
//                            .append($('#categories-menu'))
                            .append('<h4>' + $('#sidebar').data('title') + '</h4>')
                            .append($('#sidebar'))
                            .append('<h4>' + $('.top-menu-div .top-links').data('title') + '</h4>')
                            .append($('.top-menu-div .top-links'))
                            .append('<br/><br/>');

                        $(document).on('touchstart mousedown', 'input, select', function (e) {
                            e.stopPropagation();
                        });
                        myScroll = new iScroll('left-mobile-menu');
                    },
                    unmatch: function () {
                        myScroll.destroy();
                        myScroll = null;

                        $('.top-menu-div').append($('.left-mobile-menu .top-links, .left-mobile-menu form')).append($('.left-mobile-menu .languages'));
                        $('.main-layout').prepend($('#sidebar'));
                        $('.left-mobile-menu').remove();
                        $('#content').removeClass("show-left");
                    }
                });
            }
        }
    ]);
}());

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
        if (!/^"/.test(local) && !/"$/.test(local)) {
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

    $(function () {
        //Categories Popup
        $('#categories-menu .category-li > a').on('click', function () {
            // Follow final links
            if ($(this).data('has-children') === 'leaf') {
                var id = $(this).data('node-id');

                // Catalog resets all other searches
                $('#new_search input').val('');
                $('#search_catalog_ids').val(id);
                $('#new_search').submit();
                return;
            }

            $('#categories-menu .category-li').removeClass('active');
            try {
                $('.category-modal').modal('hide');
            } catch (err) {
            }
            $(this).parent().addClass('active');
        });
        $('#categories-menu .category-modal').on('hide', function () {
            $('#categories-menu .category-li').removeClass('active');
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

        var $toggle_div_switch = $('.toggle .switch div'),
            $toggle_div_switch_i = $toggle_div_switch.find('i');
        $('.toggle .switch').click(function () {
            $toggle_div_switch.toggleClass('left right');
            $toggle_div_switch_i.toggleClass('icon-km-small-white-video icon-km-small-white-audio');
            $toggle_div_switch.trigger('video_audio');
            var th4 = $(this).parent().siblings('h4');
            if ($toggle_div_switch_i.hasClass('icon-km-small-white-video')) {
                th4.html(th4.data('video'));
            } else {
                th4.html(th4.data('audio'));
            }
        });
        $('.toggle .left-switch-link').click(function () {
            $toggle_div_switch.removeClass('right').addClass('left');
            $toggle_div_switch_i.removeClass('icon-km-small-white-audio').addClass('icon-km-small-white-video');
            $toggle_div_switch.trigger('video_audio');
            var th4 = $(this).parent().siblings('h4');
            th4.html(th4.data('video'));
        });
        $('.toggle .right-switch-link').click(function () {
            $toggle_div_switch.removeClass('left').addClass('right');
            $('.toggle .switch div i').removeClass('icon-km-small-white-video').addClass('icon-km-small-white-audio');
            $toggle_div_switch.trigger('video_audio');
            var th4 = $(this).parent().siblings('h4');
            th4.html(th4.data('audio'));
        });

        $('#languages').change(function () {
            window.location = $(this).val();
        });

        // search page support
        $(document).on('click', 'a.content-type', function (e) {
            var type = $(this).data('content-type');

            e.preventDefault();

            $('#search_content_type_id').val(type);
            $('#new_search').submit();
        });

        $(document).on('click', 'a.media-type', function (e) {
            var type = $(this).data('media-type');

            e.preventDefault();

            $('#search_media_type_id').val(type);
            $('#new_search').submit();
        });

        $(document).on('change', '#language_ids', function (e) {
            e.preventDefault();

            $('#search_language_ids').val($('#language_ids').val());
            $('#new_search').submit();
        });

        // clear button on search results
        $(document).on('click', '.search-results dd .btn[data-id]', function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            var target = $(this).data('id');
            $(target).val('');
            target = $(this).data('id-more');
            if (target !== undefined) {
                $(target).val('');
            }
            $('#new_search').submit();

            return false;
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

    function window_resize() {
        $('#content').css('min-height', $(window).height() - $('.navbar').outerHeight() + 1);
    }

    $(function () {
        window_resize();
        $(window).resize(window_resize);

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

        if (typeof(vl_datepicker) !== "undefined") {
            $('#vl-datepicker').datepicker({
                autoSize: true,
                buttonImageOnly: true,
                buttonImage: '/assets/calendar.png',
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy-mm-dd',
                dayNamesMin: vl_datepicker.dayNamesMin,
                firstDay: vl_datepicker.firstDay,
                isRTL: vl_datepicker.isRTL,
                maxDate: 0,
                monthNamesShort: vl_datepicker.monthNamesShort,
                nextText: "»",
                onSelect: date_value,
                prevText: "«",
                showOn: "both"
            }).on('keydown', function (e) {
                e.preventDefault();
            });
        }
        bind_zero_clipboard();

        $(document).on('shown', '.languages-bar a[data-toggle="tab"]', function (e) {
            bind_zero_clipboard();
        });

        $(document).on('click', '.clear-filters button', function () {
            $('#new_search input').val('');
            $('#new_search').submit();
        });

        $(document).on('click', 'form#new_search button', function () {
            // Click on "Search" button should start new "clean" search
            var search_query_string = $('#search_query_string').val();
            $('#new_search input').val('');
            $('#search_query_string').val(search_query_string);
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
                    $('#leave-comment').modal('hide');
                })
                .fail(function (jqXHR, textStatus) {
                    alert("Request failed: " + textStatus);
                });

            return false;
        });

        $(document).on('click', '.left-menu-btn', function () {
//           $('.right-mobile-menu').hide();
//            $('.left-mobile-menu').show();
            $('#content').toggleClass("show-left");
        });
//        $(document).on('click','.right-menu-btn', function(){
//           $('.right-mobile-menu').show();
//           $('.left-mobile-menu').hide();
//           $('#content').removeClass("show-left").toggleClass("show-right");
//        });
    });
}());

// projekktor
(function () {
    "use strict";

    var projekktor_instance = null;

    // mark a button as active
    function nextFileStarted(itemIndex) {
        var buttons = $('.active.tab-pane .projekktor-container').siblings('.btn-toolbar').find('.btn.btn-mini');
        buttons.removeClass('active');
        $(buttons[itemIndex]).addClass('active');
    }

    // type: 'audio' or 'video'
    function setup_projekktor_playlist(type) {
//        });
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
            platforms: ['flash', 'browser', 'ios', 'android', 'native', 'vlc'],
            autoplay: false,
            controls: true,
            volume: 0.5,
//            debug: true,
            ratio: 4 / 3,
            forceFullViewport: true,
            poster: '/assets/cover-video.jpg',
            cover: '/assets/cover-video.jpg',
            playerFlashMP4: '/assets/jarisplayer.swf',
            playerFlashMP3: '/assets/jarisplayer.swf',
            messages: projekktor_messages
        });
        projekktor('.active.tab-pane .projekktor').addListener('item', nextFileStarted);
        setup_projekktor_playlist('audio');
        $('.active.tab-pane .projekktor').siblings('.btn-toolbar').find('.btn.btn-mini').first().addClass('active');
    }

    // change projekktor to another tab
    // just before show
    $(document).on('show', '.lessons-list .languages-bar a[data-toggle="tab"]', function (e) {
        if (projekktor_instance) {
            stop_projekktor();
        }
    });

    // immediately after show
    $(document).on('shown', '.lessons-list .languages-bar a[data-toggle="tab"]', function (e) {
        if (projekktor_instance) {
            stop_projekktor();
        }

        start_projekktor();
    });

    $(document).on('click', '.active.tab-pane .btn[data-item-index]', function () {
        projekktor_play($(this).data('item-index'));
    });

    $(document).on('video_audio', '.toggle .switch div', function () {
        var klass = $(this).attr('class');
        if (klass.indexOf('left') > 0) {
            setup_projekktor_playlist('video');
        } else {
            setup_projekktor_playlist('audio');
        }
    });

    $(function () {
        start_projekktor();
    });

}());
