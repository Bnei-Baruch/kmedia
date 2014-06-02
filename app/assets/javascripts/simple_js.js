//= require jquery_ujs
//= require_self

(function () {
    "use strict";

    function date_type(dateText) {
        location.href = index_url.replace(-1, dateText);

        return false;
    }

    $(function () {
        var dates_range = $('.dates_range');

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
    });

}());
