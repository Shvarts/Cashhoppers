function send_message(friend_id){
    $.ajax({
        url: '/messages/send_message',
        data: {text: $('#new_message').val(),
               friend_id: friend_id},
        type: 'POST',
        error: function(err){
        },
        success: function(data){
        }
    });
}
