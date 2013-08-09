// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require chosen-jquery
//= require twitter/bootstrap/bootstrap-transition
//= require twitter/bootstrap/bootstrap-alert
//= require twitter/bootstrap/bootstrap-modal
//= require twitter/bootstrap/bootstrap-button
//= require twitter/bootstrap/bootstrap-collapse
//= require twitter/bootstrap/bootstrap-carousel
//= require bootstrap-datetimepicker
//= require wice_grid
//= require bootstrap-fileupload.min

$(document).ready(function(){
    buttonselect();
})


function buttonselect(){

    var useragent = navigator.userAgent.toLowerCase();


    if( useragent.match("ios")){
        $(".button-container").html("<a href='/users/sign_in'><img src = '/assets/button-app-store.png' width = '65%'</a>")

    }
    else if(useragent.match("android") ) {
        $(".button-container").html("<a href='/users/sign_in'><img src = '/assets/button-google-play.jpg' width = '65%'</a>")

    }
}