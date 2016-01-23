$(document).ready(function(){
    var groups = $('#group_').html();
    var course = $('#course_ option:selected').text();

    if (course.length > 0) {
        var options = $(groups).filter("optgroup[label='" + course + "']").html();
        if (options) {
            $('#group_').html(options);
            $("#group_").prepend("<option value=''></option>");
        } else {
            $('#group_').empty();
        };
    };

});

$(document).ready(function(){
    $('#course_').change(function(){
        $('#group_').empty();
        $('#filter_calendar').submit();
    });
    $('#group_').change(function(){
        $('#filter_calendar').submit();
    });
})


//this for new period simple form
$(document).bind('page:change', function(){
    var groups = $('#period_group_id').html();
    var course_elements = $('#period_course_element_id').html();
    $('#period_course_id').change(function(){
        var course = $('#period_course_id option:selected').text();
        var options = $(groups).filter("optgroup[label='" + course + "']").html();
        var options_course_el = $(course_elements).filter("optgroup[label='" + course + "']").html();
        if (options) {
            $('#period_group_id').html(options);
        } else {
            $('#period_group_id').empty();
        };
        if (options_course_el){
            $('#period_course_element_id').html(options_course_el);
        } else {
            $('#period_course_element_id').empty();
        };
    });
});





//this is FullCalendar
$(document).bind('page:change', function() {

    var url = $("#calendar").attr('data-request-url');
    console.log(url);

    $('#calendar').fullCalendar({
        dayClick:  function(event, jsEvent, view) {
            // change the day's background color just for fun
            $(this).css('background-color', 'green');
            //set the values and open the modal
            $("#eventInfo").html(event.description);
            $("#eventLink").attr('href', event.url);
            $("#eventContent").dialog({ modal: true, title: event.title });
        },
        events: url + '.json',
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },

        eventRender: function(event, element) {
            var full_time = new Date(Date.parse(event.start));
            var hours = full_time.getHours();
            var minutes = full_time.getMinutes();
            if (minutes < 10){
                var time = hours+':0'+minutes;
            }else{
                var time = hours+':'+minutes;
            }
            var content = '<a href="'+'/courses/'+event.course_id+'/course_elements/'+event.course_element_id+'">'+
                event.theme + '</a>' +
                '<br> Тип занятия: ' +
                event.element_type ;

            console.log(event);
            element.html(time +
                '<span class="removeEvent glyphicon glyphicon-trash pull-right"  data-action="delete"></span>'+
                '<br>'+' '+event.name +'<br>' +
                ' '+event.title
            );

            element.popover({
                title: time + ' ' + event.title,
                content: content,
                html: true,
                trigger: 'hover',
                delay: {
                    show: "1000",
                    hide: "2000"
                }
            });
        },
        eventClick: function(calEvent, jsEvent, view) {

            if ($(jsEvent.target).attr('data-action') == 'delete') {

                var doDelete = confirm('Вы действительно хотите удалить?');

                if (doDelete) {
                    var source = '/groups/:group_id/periods/' + calEvent.id;

                    $('#calendar').fullCalendar('removeEvents', calEvent._id);

                    $.ajax({
                        url: source,
                        type: "POST",
                        data: { _method:'DELETE' },
                        success: function(msg) {
                            console.log('ajax request completed');
                        }
                    });
                }

            }
        },
        eventMouseover: function(calEvent, jsEvent, view) {
            //console.log(calEvent);

            $(this).popover(
                {}
            );
            return true;
        },
        dayClick: function(date, jsEvent, view) {

            var course = $('#course_').val();
            $('#period_course_id').val(course);

            var group = $('#group_').val();
            $('#period_group_id').val(group);

            var course_selected = $('#course_ option:selected').text();
            var course_elements = $('#period_course_element_id').html();
            console.log(course_selected)
            var options_course_el = $(course_elements).filter("optgroup[label='" + course_selected + "']").html();
            if (options_course_el){
                $('#period_course_element_id').html(options_course_el);
            }

            var day_m = parseInt(date.date());
            $('#period_commence_datetime_3i').val(day_m);

            var month_m = parseInt(date.month() + 1);
            $('#period_commence_datetime_2i').val(month_m);

            var year_m = parseInt(date.year());
            $('#period_commence_datetime_1i').val(year_m);

            $('#myModal').modal('toggle');
        }

    });

});
