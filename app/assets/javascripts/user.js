// We removed the bootstrap-scrollspy because it caused a bug of setting dropdown tab active after scroll
//= require bootstrap-transition
//= require bootstrap-alert
//= require bootstrap-button
//= require bootstrap-collapse
//= require bootstrap-dropdown
//= require bootstrap-modal
//= require bootstrap-tab
//= require bootstrap-tooltip

//= require jquery.zclip.min
//= require jquery-ui-1.10.4.datepicker
//= require jwplayer/jwplayer

//= require_self

(function () {
    "use strict";

    $(document).on('click', '.books-catalog a.books-expander', function () {
        var $this = $(this), $parent = $this.parent('li');
        $parent.toggleClass('expand');
    });

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
                            .append('<h4>' + $('#categories-menu').data('title') + '</h4>')
                            .append($('#categories-menu'))
                            .append('<h4>' + $('#sidebar').data('title') + '</h4>')
                            .append($('#sidebar'))
                            .append('<h4>' + $('.top-menu-div .top-links').data('title') + '</h4>')
                            .append($('.top-menu-div .top-links'))
                            .append('<br/><br/>');

                        $(document).on('touchstart mousedown', 'input, select', function (e) {
                            e.stopPropagation();
                        });
                    },
                    unmatch: function () {
                        $('.top-menu-div').append($('.left-mobile-menu .top-links, .left-mobile-menu form')).append($('.left-mobile-menu .languages'));
                        $('.main-layout').prepend($('#sidebar'));
                        $('#content .topbanner').after($('#categories-menu'));
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
                var name = value.name;
                try {
                    children = all_tree[value.id].length;
                } catch (err) {
                    children = 0;
                }
                children_str = children > 0 ? ' <span class="children-amount">(' + children + ')</span> <span class="expander"></span>' : '';
                html += '<li><a href="javascript:;" data-has-children="' + (children > 0) + '" data-node-id="' + value.id + '">' + name + children_str + '</a></li>';
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

    function date_type(dateText) {
        $('.daterange').html(dateText);
        $('#search_date_type').val('one_day');
        $('#search_dates_range').val(dateText);
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

        var dates_range = $('.dates_range'),
            vl_datepicker = $('#vl-datepicker');

        if (dates_range.length > 0) {
            dates_range.datepicker({
                autoSize: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy-mm-dd',
                dayNamesMin: datepicker_info.dayNamesMin,
                defaultDate: dates_range_value,
                firstDay: datepicker_info.firstDay,
                isRTL: datepicker_info.isRTL,
                maxDate: 0,
                monthNamesShort: datepicker_info.monthNamesShort,
                nextText: "»",
                onSelect: date_type,
                prevText: "«",
                showOn: "both"
            });
        }
        if (vl_datepicker.length > 0) {
            vl_datepicker.datepicker({
                altField: '#vl-datepicker-alt',
                altFormat: 'yy-mm-dd',
                autoSize: true,
                buttonImage: '/assets/calendar.png',
                changeMonth: true,
                changeYear: true,
                dateFormat: 'yy-mm-dd',
                dayNamesMin: datepicker_info.dayNamesMin,
                firstDay: datepicker_info.firstDay,
                isRTL: datepicker_info.isRTL,
                maxDate: 0,
                monthNamesShort: datepicker_info.monthNamesShort,
                nextText: "»",
                onSelect: date_value,
                prevText: "«",
                showOn: "both"
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
            $('#content').toggleClass("show-left");
        });
    });
}());

// jwplayer

var jwcontroller = {
    instance: null,
    language: 'en',
    type: 'audio',

    // type: 'audio' or 'video'
    setup_playlist: function (language, type) {
        "use strict";

        if (language !== null) {
            jwcontroller.language = language;
        }
        jwcontroller.type = type;
    },

    create: function () {
        "use strict";

        // Start jwplayer on active tab-pane only
        if ($('.active.tab-pane .player-div').length === 0) {
            return;
        }

        jwcontroller.instance = jwplayer(jwcontroller.language + '_player').setup({
            autostart: false,
            controls: true,
            image: "/assets/cover-video.jpg",
            primary: 'HTML5',
            flashplayer: '/assets/jwplayer/jwplayer.flash.swf',
            html5player: '/assets/jwplayer/jwplayer.html5.js',
            stretching: 'fill',
//            skin: 'jwplayer-skins-premium/six.xml',

            playlist: window['playlist_' + jwcontroller.language + '_' + jwcontroller.type],
            listbar: {
                position: 'none'
            },
            width: '100%',
            aspectratio: '4:3'
        });

        jwcontroller.instance.onReady(function () {
            var playlist = jwcontroller.instance.getPlaylist(),
                index,
                klass,
                html = '<table class="table table-condensed table-hover table-playlist"><tbody>',
                current_date = playlist[0].date;
            for (index = 0; index < playlist.length; index++) {
                if (playlist[index].date !== current_date) {
                    current_date = playlist[index].date;
                    klass = ' class="date-was-changed" ';
                } else {
                    klass = '';
                }
                html += '<tr data-index="' + index + '"' + klass + '><td><span class="playlist-number">' + (index + 1) + '</span><i class="icon-play-circle"></i></td><td>' + playlist[index].description + '</td><td>' + playlist[index].time + '</td></tr>';
            }
            $('#' + jwcontroller.language + '_playlist').html(html + '</tbody></table>');
        });

        jwcontroller.instance.onPlaylistItem(function (obj) {
            var self = $('#' + jwcontroller.language + '_playlist tr[data-index=' + obj['index'] + ']');
            jwcontroller.markActive(self);
        });
        jwcontroller.instance.onPlaylistComplete(function () {
            var self = $('#' + jwcontroller.language + '_playlist tr[data-index=0]');
            jwcontroller.markActive(self, true);
        });
    },

    destroy: function () {
        "use strict";

        if (jwcontroller.instance) {
            try {
                jwcontroller.instance.stop();
                jwcontroller.instance.remove();
            } finally {
                jwcontroller.instance = null;
            }
        }
    },

    playThis: function (index) {
        "use strict";

        jwcontroller.instance.playlistItem(index);
    },

    markActive: function (self, just_remove) {
        "use strict";

        self.siblings().removeClass('active');
        if (just_remove === undefined) {
            self.addClass('active');
        }
    }
};


(function () {
    "use strict";

    if ($('.player-container').length === 0) { return; }

    // change jwplayer to another tab
    // just before show
    $(document).on('show', '.lessons-list .languages-bar a[data-toggle="tab"]', function () {
        jwcontroller.destroy();
    });

    // immediately after show
    $(document).on('shown', '.lessons-list .languages-bar a[data-toggle="tab"]', function (e) {
        var language = $(e.target).data('language'),
            type = $('.audio-video-switch .active').attr('class').indexOf('left') !== -1 ? 'video' : 'audio';
        jwcontroller.destroy();
        jwcontroller.setup_playlist(language, type);
        jwcontroller.create();
    });

    $(document).on('click', '.audio-video-switch a', function (e) {
        e.preventDefault();
        e.stopImmediatePropagation();

        var klass = $(this).attr('class'),
            h4 = $('.toggle-h4');
        jwcontroller.destroy();
        if (klass.indexOf('left') !== -1) {
            jwcontroller.setup_playlist(null, 'video');
            $('.audio-video-switch .left-switch-link').addClass('active');
            $('.audio-video-switch .right-switch-link').removeClass('active');
            h4.html(h4.data('video'));
        } else {
            jwcontroller.setup_playlist(null, 'audio');
            $('.audio-video-switch .right-switch-link').addClass('active');
            $('.audio-video-switch .left-switch-link').removeClass('active');
            h4.html(h4.data('audio'));
        }
        jwcontroller.create();
    });

    $(document).on('click', '.playlist-div tr', function () {
        var index = $(this).data('index');
        jwcontroller.playThis(index);
    });

    jwplayer.key = "xmnkkk/ActOXPTodF7so92Iu+Z3lelSDhlgvXGzWKYk=";

    var interface_language = $('.languages-bar li.active a').data('language'),
        type = $('.audio-video-switch .active').attr('class').indexOf('left') !== -1 ? 'video' : 'audio';
    jwcontroller.setup_playlist(interface_language, type);
    jwcontroller.create();

}());
