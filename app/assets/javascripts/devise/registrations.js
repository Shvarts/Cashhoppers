$(document).ready(function(){

    $('#agreement').click(function(){
        if ($('#agreement').is(':checked')) {

            $('.sign-up-button').attr('disabled',false);
        } else {

            $('.sign-up-button').attr('disabled',true);
        }
    });
})