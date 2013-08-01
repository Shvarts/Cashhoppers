function search_user(){

    users_modal.loadPartial('/admin/hoppers/search_user',{},'Users')


}
function search_hop(){

    hops_modal.loadPartial('/admin/hoppers/search_hop_list',{},'Hops')

}

function search_zip(){

    zips_modal.loadPartial('/admin/hoppers/search_zip_list',{},'Zip')


}

function select(url){
    $.ajax({
        url: url,
        data: {},
        type: 'POST',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#container').html(data);

            $('#modal-crud-window').modal('hide');
        }
    });
}

function search_by(url){
    $.ajax({
        url: url,
        data: {params: $('#search_field').val() },
        type: 'POST',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('.modal-body').html(data);
        }
    });
}


$(document).ready(

    search('/admin/hoppers/search_by_hop', '#search_hop'),
    search('/admin/hoppers/search_by_zip', '#search_zip'),
    search('/admin/hoppers/search_by_name', '#search_name')


)

function search(url, button){

    $(document).on('click', button , function(){
        search_by(url);
        return false;
   })
}
