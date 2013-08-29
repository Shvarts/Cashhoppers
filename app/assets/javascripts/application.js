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

    $('.gallery-2').css('width','78%')


    $(".collapse").collapse();


    dropdown();
    service_menu();
    default_hide_dropdown();

});


function buttonselect(){

    var useragent = navigator.userAgent.toLowerCase();

    if( useragent.match("iphone")){
        $(".button-container").html("<a href='http://www.apple.com/itunes/?cid=OAS-US-DOMAINS-itunes.com'><img src = '/assets/button-app-store.png' class = 'phone-button'></a>")
    }
    else if(useragent.match("android") ) {
        $(".button-container").html("<a href='https://play.google.com/store'><img src = '/assets/button-google-play.jpg' class = 'phone-button'></a>")
    }

}

function default_hide_dropdown(){
       $('html').click(function(){

               $('.btn-group ul').hide('slow');
           }
   )
}


function dropdown(){


    $('.btn-group ul.menu').hide();
    $(' .btn-group> ul >li> a').css('color', 'black');
    $(' .btn-group> ul.dropdown-menu.menu').css('background-color', 'green');
    $(' .btn-group> ul.dropdown-menu.menu').width($('html').width());
    $('.button-container.text-right .btn-group ul').width('100%')

    $(' .btn-group').css('max-height', '200px');
    $('.btn-group .btn.dropdown-toggle.btn-navbar.btn-success').click(function(){
        $('.btn-group ul.menu').toggle('slow') ;
        menu_hide();

        return false;

   })

}


function menu_hide(){
   $('.dropdown-menu.menu li a').click(function(){
        $('.btn-group ul.menu').hide('slow');

     })

}
function button_menu_hide(){
   $('.dropdown-menu.button li a').click(function(){

        $('.btn-group ul').hide('slow');


     })

}



function service_menu(){

    button_menu_hide();
  $('.header-right .button-container.text-right .btn-group input.btn-warning, #download_app').click(function(){
      $('.button-container.text-right .btn-group ul ').css('background-color', 'green');
      $('.button-container.text-right .btn-group ul ').css('left', '-25%');

         $('ul.dropdown-menu.button').toggle('slow') ;


          return false;
  })


}
