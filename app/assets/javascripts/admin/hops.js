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

function change_user_prize(sender){
    if(!confirm("Are you sure you want to change user role ?")){
        return;
    }
    $.ajax({
        url: "/admin/prizes/update",
        data: { prize: { user_id:$(sender).attr('user_id')}, prize_id: $(sender).val()},
        type: 'PUT',
        beforeSend: function () {
        },
        complete: function(){
        },
        error: function(err){
            alert("error");
        },
        success: function(data){
            prizes_modal.updateTable({});
        }
    });


}

function place_hide(){

    $('.place-field').hide();
}
function place_non_hide(){

    $('.place-field').show();
}
