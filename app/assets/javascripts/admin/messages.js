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