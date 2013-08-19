$(document).ready(function(){
    search('/admin/messages/hops_list', '#search_hop')
    search('/admin/messages/users_list', '#search_user')

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

//function search_hop(){
//    alert('click') ;
//
////    var exception_field_id = hops_modal.exception_field_id;
////    var params = {};
////    params.query = $('#query').val();
////    if(exception_field_id == 'hops_ids_'){
////        params = {selected_hops: $('.chzn-select#' + exception_field_id).val() };
////    }
////    if(exception_field_id == 'users_ids_'){
////        params = {selected_users: $('.chzn-select#' + exception_field_id).val() };
////    }
////    hops_modal.loadPartial(hops_modal.index_path, params, 'Select Hops:');
//}

function search(url, button){

    $(document).on('click', button , function(){
        search_by(url);
        return false;
    })
}

function search_by(url){
//    $.ajax({
//        url: url,
//        data: {query1: $('#search_field').val() },
//        type: 'get',
//        error: function(err){
//            alert("error");
//        },
//        success: function(data){
//            $('.modal-body').html(data);
//        }
//    });
    hops_modal.loadPartial(url, {query1: $('#search_field').val() }, 'Select:');
}

function winner_hop(select){
    if($(select).val()==1  ){
        $('.new-hop').html('');
        $('.hop-winner').html('');
        $('.subject-container').show();
    }
   else if($(select).val()==2){
     $('.hop-winner').html("PRIZE PLACE: <input name = 'prize_place' value = ''  placeholder='put prize place'></input><br  /><br  />NAME OF HOP: <input name = 'hop_name' value = '' placeholder='put hop name' ></input>");
     $('.new-hop').html('');
     $('.subject-container').hide();
   }
   else if($(select).val()==3){
     $('.new-hop').html("HOP NAME: <input name = 'hop_name' value = '' placeholder='put hop name' ></input><br  />")
     $('.subject-container').show();
     $('.hop-winner').html('');
   }
}

