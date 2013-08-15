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


    $(".collapse").collapse();

    menu_hide();
    dropdown();
    $('.nav-collapse.collapsed.collapse').hide();


});


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



}
function dropdown(){


    $('button.btn.btn-navbar').one('click',function(){
        $('.nav-collapse.collapsed.collapse').show();

        hide_dropbox();
        $('.nav-collapse.collapse').addClass('in');


       if($('.nav-collapse.in.collapse').height()==0){



       }

   })

}
function menu_hide(){

    $('.nav-collapse.collapse ul >li> a.navigation').click(function(){
        hide_dropbox();

    })

}

function hide_dropbox(){
    $('.nav-collapse.collapse').height('0px') ;
    $('button.btn.btn-navbar').addClass('collapsed');

    $('.nav-collapse.collapse').removeClass('in');


}
//function menu_show(){
//    alert('text');
//    $('.btn.btn-navbar').click(function(){
//        alert('text');
//    $('.nav-collapse.collapse ul >li> a.navigation').click(function(){
//        $('ul.nav').show();
//
//    })
//    })
//}
//function service_menu(){
//
//  $('.button-container.text-right .btn-group a.dropdown-toggle').click(function(){
//
//          $('.btn-group ul.button ').toggle() ;
//          menu_hide();
//          return false;
//  })
//}