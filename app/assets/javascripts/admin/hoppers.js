function search_user(){

    users_modal.loadPartial('/admin/hoppers/search_user',{},'Users')
}

function select_user(url){
    $.ajax({
        url: url,
        data: {},
        type: 'POST',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#hopper_info').html(data);

            $('#modal-crud-window').modal('hide');
        }
    });
}
