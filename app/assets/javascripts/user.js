//= require jquery
//= require modernizr.custom
//= require jquery_ujs
//= require_self
//= require_tree ./common
//= require_tree ./user
//= require bootstrap

$(document).ready(function () {

    //Close popups
    $('.close-popup').click(function () {
        $(this).parents('.popup').css('display', 'none');
    });

    //Categories Popup
    $('.categories a').click(function () {
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

});
