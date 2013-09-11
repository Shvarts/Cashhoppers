function unsubscribe_user(sender){


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


}