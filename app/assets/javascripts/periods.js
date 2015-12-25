

$(document).bind('page:change', function() {

    var url = $("#calendar").attr('data-request-url');
    console.log(url);

    $('#calendar').fullCalendar({
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
                'Занятие '+event.title
            );

            element.popover({
                title: time + '|Занятие ' + event.title,
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

    });
});
