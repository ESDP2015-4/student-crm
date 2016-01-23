$(document).bind('page:change', function () {
    var groups = $('#group_').html();

    $('#select_course_').change(function () {
        var course = $('#select_course_ option:selected').text();
        var options = $(groups).filter("optgroup[label='" + course + "']").html();
        if (options) {
            $('#group_').html(options);
        } else {
            $('#group_').empty();
        }
        ;
    });
});