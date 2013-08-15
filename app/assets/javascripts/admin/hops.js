$(function(){
    $('.align-error').css('color', 'red')
    $('#load').click(function(e){
        var myRe = /\.xls$/;

        var val = myRe.exec($('#excel').val());

        if( val !=null){

           // $('.align-error').html('File wrong');
        }
        else{
            e.preventDefault();
            $('.align-error').html('File was no choose or bad file formal');
            alert('File was no choose or bad file formal')
        }

    })


})

$(document).ready(function(){
        validate_prize();
    }
  $(document).on('click', $('a.create-prize'), function(){

      alert('text');
      }
)

function validate_prize(){

    $('a.create-prize').on('click', function(){

        alert('text');
    })

//    $('#load').click(function(e){
//        var myRe = /\.xls$/;
//
//        var val = myRe.exec($('#excel').val());
//
//        if( val !=null){
//
//            // $('.align-error').html('File wrong');
//        }
//        else{
//            e.preventDefault();
//            $('.align-error').html('File was no choose or bad file formal');
//            alert('File was no choose or bad file formal')
//        }
//
//    })


}



