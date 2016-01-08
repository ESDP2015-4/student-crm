// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require jquery-ui/sortable
//= require jquery-ui/effect-highlight
//= require turbolinks
//= require moment
//= require fullcalendar
//= require_tree .

//this function calls alert close method to close an alert
function clearFlash() {
    $(".alert").alert('close');
}
//this function calls clearFlash method after 3 seconds
var clearFlashOnReady = function () {
    setTimeout(clearFlash, 3000);
};

//this function hides and shows avatars of users
function hideshow(which){
    if (!document.getElementsByClassName)
        return
    for(var i = 0; i < which.length; i++){

        if (which[i].style.display=="none")
            which[i].style.display="block";
        else
            which[i].style.display="none"
    }
};


// this is for live search/sort for users
$(function() {
    $(document).delegate("#users th a","click", function() {
        $.getScript(this.href);
        return false;
    });
    $(document).ready("#users_search input").keyup(function() {
        $.get($("#users_search").attr("action"), $("#users_search").serialize(), null, "script");
        return false;
    });
});

