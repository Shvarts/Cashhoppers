function search_user(){

    users_modal.loadPartial('/admin/hoppers/search_user',{},'Users')


}
function search_hop(){

    hops_modal.loadPartial('/admin/hoppers/search_hop_list',{},'Hops')

}

function search_zip(){

    zips_modal.loadPartial('/admin/hoppers/search_zip_list',{},'Zip')


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
function select_hop(url){
    $.ajax({
        url: url,
        data: {},
        type: 'POST',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#hopper_list').html(data);

            $('#modal-crud-window').modal('hide');
        }
    });
}
function select_zip(url){
    $.ajax({
        url: url,
        data: {},
        type: 'POST',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#hopper_list').html(data);

            $('#modal-crud-window').modal('hide');
        }
    });
}
