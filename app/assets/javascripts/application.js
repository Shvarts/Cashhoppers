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
    page_size();
    $('.gallery-2').css('width','78%')
    dropdown();
    service_menu();
    $(".collapse").collapse()

})


function buttonselect(){

    var useragent = navigator.userAgent.toLowerCase();


    if( useragent.match("iphone")){
        $(".button-container").html("<a href='/users/sign_in'><img src = '/assets/button-app-store.png' ></a>")

    }
    else if(useragent.match("android") ) {
        $(".button-container").html("<a href='/users/sign_in'><img src = '/assets/button-google-play.jpg'></a>")

    }
}

function page_size(){

//    $('.header-container').css('height', $('html').css('height')*0.2);
//    $('.custom-pg').css('min-height',parseInt($('html').css('height').replace(/px/,""))-parseInt($('.header').css('height').replace(/px/,"")) +'px');


}
function dropdown(){
    $('.btn-group ul').hide();

    $(' .btn-group> ul >li> a').css('color', 'black');
    $('.btn-group.collapse-search ul').width( $('html').width()) ;
    $('.btn-group.collapse-search ul').css('background-color','green');
    $('.btn-group .btn').click(function(){
        $('.btn-group ul.menu').toggle() ;
        menu_hide();
        return false;
   })

}
function menu_hide(){
    $(' .btn-group> ul >li> a').click(function(){
        $('.btn-group ul').hide();

    })

}
function service_menu(){

  $('.button-container.text-right .btn-group a.dropdown-toggle').click(function(){

          $('.btn-group ul.button ').toggle() ;
          menu_hide();
          return false;
  })
}