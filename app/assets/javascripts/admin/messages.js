$(document).ready(function(){

    $('.chzn-select').chosen();

    $('#hops_ids__chzn').click(function(){
        var params = {};
        if($('.chzn-select#hops_ids_').val() != null){
            params.selected_hops = $('.chzn-select#hops_ids_').val();
        }
        hops_modal.loadPartial('/admin/messages/hops_list', params, 'Select Hops:');
    });

    $('#hops_ids__chzn .chzn-results').css('display', 'none');

    $('#users_ids__chzn').click(function(){
        var params = {};
        if($('.chzn-select#users_ids_').val() != null){
            params.selected_users = $('.chzn-select#users_ids_').val();
        }
        users_modal.loadPartial('/admin/messages/users_list', params, 'Select Users');
    });

    $('#users_ids__chzn .chzn-results').css('display', 'none');
});

function select_hop(btn, value, title){
    $(btn).removeClass('btn-success').attr('onclick', '');
    $('#hops_ids_').append("<option selected value=" + value + ">" + title +"</option>");
    $('#hops_ids_').trigger("liszt:updated");
}

function select_user(btn, value, title){
    $(btn).removeClass('btn-success').attr('onclick', '');
    $('#users_ids_').append("<option selected value=" + value + ">" + title +"</option>");
    $('#users_ids_').trigger("liszt:updated");
}

function search_hop(){
    var exception_field_id = hops_modal.exception_field_id;
    var params = {};
    params.query = $('#query').val();
    if(exception_field_id == 'hops_ids_'){
        params = {selected_hops: $('.chzn-select#' + exception_field_id).val() };
    }
    if(exception_field_id == 'users_ids_'){
        params = {selected_users: $('.chzn-select#' + exception_field_id).val() };
    }
    hops_modal.loadPartial(hops_modal.index_path, params, 'Select Hops:');
}