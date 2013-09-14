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
//    sign-up insert url-file
    $('input[id=lefile]').change(function() {
        $('.fileupload-preview.fileupload-exists.thumbnail').css('max-width', $('.fileupload-preview.fileupload-exists.thumbnail').width());
        $('.fileupload-preview.fileupload-exists.thumbnail').css('margin', $('.fileupload-preview.fileupload-exists.thumbnail').css('margin'));
       $('#photoCover').css('max-width',($('#photoCover').css('width')));
        $('#photoCover').val($(this).val());


    });

    dropdown();
    service_menu();
    default_hide_dropdown();

});


function buttonselect() {

    var useragent = navigator.userAgent.toLowerCase();

//    if (useragent.match("iphone")) {
    if (useragent.match("iphone")) {
        $(".button-container").html("<a href='http://www.apple.com/itunes/?cid=OAS-US-DOMAINS-itunes.com'><img src = '/assets/button-app-store.png' class = 'phone-button'></a>");
        $(".button-container a img").css('position', 'absolute');
        $(".button-container a img").css('top', '0px');
        $(".button-container a img").css('right', '5px');
        $(".button-container a img").css('width', '100px');
        $(".button-container a img").css('border', 'none');
        $('.download_app').attr('href', 'http://www.apple.com/itunes/?cid=OAS-US-DOMAINS-itunes.com');
    }
    else if (useragent.match("android")) {
        $(".button-container").html("<a href='https://play.google.com/store'><img src = '/assets/button-google-play.png' class = 'phone-button'></a>");
        $(".button-container a img").css('position', 'absolute');
        $(".button-container a img").css('top', '0px');
        $(".button-container a img").css('right', '5px    ');
        $(".button-container a img").css('width', '100px');
        $(".button-container a img").css('border', 'none');
        $('.download_app').attr('href', 'https://play.google.com/store');
    }
    else {
        $('.download_app').click(function () {
            $('.dropdown-menu.button#dropdown ').css('background-color', 'rgb(51, 51, 51)');


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
    $(' ul.dropdown-menu.button#dropdown> li:last-child >a').css('border-bottom', 'none');
    $(' .btn-group> ul >li ').css('border-top', '1px solid #363F43');
    $(' ul.dropdown-menu.button#dropdown> li:first-child ').css('border-top', 'none');

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
    $('#download-button').click(function () {
        $('.dropdown-menu.button#dropdown').css('background-color', 'rgb(51, 51, 51)');


        $('ul.dropdown-menu.button').toggle('slow');


        return false;
    })


}


function unsubscribe_user_profile(sender){


        $.ajax({
            url: "",
            data: { user_id: $(sender).attr('user_id'), subscribe: $(sender).attr('subscribe')},
            type: 'GET',
            beforeSend: function () {
            },
            complete: function(){
            },
            error: function(err){
                alert("error");
            },
            success: function(data){

                $('#subscribe').html(data);
            }
        });


};




