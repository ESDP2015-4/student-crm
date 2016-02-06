

$(document).on('page:change', function(){
    // this for filter check boxes
    $(".panel-title input:checkbox").cbFamily(function (){
        return $(this).parents("div:first").next().find("input:checkbox");
    });

    $('.panel-body label input[type="checkbox"]').change(function(){
        var group_value = $(this).closest('.panel-body').find('input[type="checkbox"]').val(),
            title = $(this).parent().text();
        if($(this).is(':checked')){
            var html = '<button value="' + group_value + '" type="button" class="btn btn-info btn-xs"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>' + title + '</button>';
            $('.checked_groups').append(html + ' ');

        } else {
            $('button[value="' + group_value + '"]').remove();
        };
    });

    $('.checked_groups').click(function(){
        $('button').click(function(){
            var group_value = $(this).val()
            $('input[value="' + group_value + '"]').attr('checked',false);
            $('button[value="' + group_value + '"]').remove();
        });
    });


    //this for new period simple form (modal)
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

        firstDay: 1,

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
            console.log(course_selected);
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

            var deadline_date = new Date(date.format());
            deadline_date.setDate(deadline_date.getDate() + 7);

            var deadline_day = deadline_date.getDate();
            var deadline_month = deadline_date.getMonth() + 1;
            var deadline_year = deadline_date.getFullYear();

            $('#period_deadline_3i').val(deadline_day);
            $('#period_deadline_2i').val(deadline_month);
            $('#period_deadline_1i').val(deadline_year);

            $('#myModal').modal('toggle');
        },
        editable: true,
        eventDrop: function(event, delta, revertFunc) {
            if (!confirm('Занятие ' + event.title + ' будет перенесено на дату ' +
                    event.start.format() + '.' + ' Сохранить изменения?')) {
                revertFunc();
            }
        },

        monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
        monthNamesShort: ['Январь','Февраль','Март','Апрель','Май','Июнь','Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
        dayNames: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],
        dayNamesShort: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"],

        buttonText: {
            today: "Сегодня",
            month: "Месяц",
            week: "Неделя",
            day: "День"
        }

    });

    $('.panel.panel-default').click(function(){
        var selected_groups = $(".panel-body label input[type=checkbox]:checked").map(function(){
            return $(this).val()
        }).get();
        $.ajax({
            type: 'GET',
            url: '/selected_groups/',
            data: {
                "group_ids": selected_groups
            },
            success: function(data){
                $('#calendar').fullCalendar('removeEvents');
                $("#calendar").fullCalendar("addEventSource", data)
                console.log(data)
            }
        });
    });

    $('.checked_groups').click(function(){
        var selected_groups = $(".panel-body label input[type=checkbox]:checked").map(function(){
            return $(this).val()
        }).get();
        $.ajax({
            type: 'GET',
            url: '/selected_groups/',
            data: {
                "group_ids": selected_groups
            },
            success: function(data){
                $('#calendar').fullCalendar('removeEvents');
                $("#calendar").fullCalendar("addEventSource", data)
                console.log(data)
            }
        });
    });

});
