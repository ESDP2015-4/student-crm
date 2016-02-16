$('page:change', function(){
    // this for filter check boxes
    $(".panel-title input:checkbox").cbFamily(function (){
        return $(this).parents("div:first").next().find("input:checkbox");
    });
});
