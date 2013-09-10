$(function(){
    $('.align-error').css('color', 'red')
    $('#load').click(function(e){
        var myRe = /\.xlsx$/;

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
    $('.carousel').carousel({
        interval: 4000

    })



})

function change_user_prize(sender){
    if(!confirm("Are you sure you want to change winner ?")){
        return;

    }

    $.ajax({
        url: "/admin/prizes/"+$(sender).val()+"",
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

    $('#description').show();
    $('.place-field').hide();
}
function special_prize(){

    $('#description').hide();
    $('.place-field').show();
    $('.place-field').attr('type','text');
}
function place_prize(){

    $('#description').hide();
    $('.place-field').show();
    $('.place-field').attr('type','number');
}


function update_hoppers(id){

    $.ajax({
        url: '/admin/hops/render_hoppers',
        data:{hop_id: id},
        type: 'GET',
        contentType: 'text',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#hoppersTable').html(data);
        }
    });
};

function center_carousel(){
$('#hopPhotos .carousel-inner .active.item img').each(function() {
    $(this).css('margin-top', ($(this).parent().height() - $(this).height())/2 + 'px' ) ;
});
}