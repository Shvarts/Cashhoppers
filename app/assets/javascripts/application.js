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

$(document).ready(function () {
    buttonselect();

    $('.gallery-2').css('width', '78%')


    $(".collapse").collapse();


    dropdown();
    service_menu();
    default_hide_dropdown();

});


function buttonselect() {

    var useragent = navigator.userAgent.toLowerCase();

    if (useragent.match("iphone")) {
        $(".button-container").html("<a href='http://www.apple.com/itunes/?cid=OAS-US-DOMAINS-itunes.com'><img src = '/assets/button-app-store.png' class = 'phone-button'></a>");
        $('.download_app').attr('href', 'http://www.apple.com/itunes/?cid=OAS-US-DOMAINS-itunes.com');
    }
    else if (useragent.match("android")) {
        $(".button-container").html("<a href='https://play.google.com/store'><img src = '/assets/button-google-play.jpg' class = 'phone-button'></a>");
        $('.download_app').attr('href', 'https://play.google.com/store');
    }
    else {
        $('.download_app').click(function () {
            $('.button-container.text-right .btn-group ul ').css('background-color', 'green');
            $('.button-container.text-right .btn-group ul ').css('left', '-2%');

            $('ul.dropdown-menu.button').toggle('slow');


            return false;
        })

    }

}

function default_hide_dropdown() {
    $('html').click(function () {

            $('.btn-group ul').hide('slow');
        }
    )
}


function dropdown() {


    $('.btn-group ul.menu').hide();
    $(' .btn-group> ul >li> a').css('color', 'white');
    $(' .btn-group> ul >li> a').css('font-weight', 'bold');
    $(' .btn-group> ul >li>a').css('padding', '9px 15px');
    $(' .btn-group> ul >li >a').css('border-bottom', '1px solid black');
    $(' .btn-group> ul >li >a').css('border-top', '1px solid #363F43');
    $(' .btn-group> ul.dropdown-menu.menu').css('background-color', 'rgb(51, 51, 51)');
    $(' .btn-group> ul.dropdown-menu.menu').width($('html').width());

    if ($('html').height() < 400) {

        $(' .btn-group> ul.dropdown-menu.menu').height(($('html').height() - 35) + 'px');
    }


//    $(' .btn-group').css();
    $('.btn-group .btn.dropdown-toggle.btn-navbar.btn-success').click(function () {
        $('.btn-group ul.menu').toggle('slow');
//        $(' .header ').css('position', 'relative');
        menu_hide();


        return false;

    })


}


function menu_hide() {
    $('.dropdown-menu.menu li a').click(function () {
        $('.btn-group ul.menu').hide('slow');
//       $(' .header ').css('position', 'fixed');
    })

}
function button_menu_hide() {
    $('.dropdown-menu.button li a').click(function () {

        $('.btn-group ul').hide('slow');


    })

}


function service_menu() {


    button_menu_hide();
    $('.header-right .button-container.text-right .btn-group input.btn-warning').click(function () {
        $('.button-container.text-right .btn-group ul ').css('background-color', 'green');
        $('.button-container.text-right .btn-group ul ').css('left', '-2%');

        $('ul.dropdown-menu.button').toggle('slow');


        return false;
    })


}
