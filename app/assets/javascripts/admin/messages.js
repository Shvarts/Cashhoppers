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
    winner_hop($('.template-select'));
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



function search(url, button){

    $(document).on('click', button , function(){
        search_by(url);
        return false;
    })
}

function search_by(url){

    hops_modal.loadPartial(url, {query1: $('#search_field').val() }, 'Select:');
}



function winner_hop(select){

    if($(select).val()==1){
        $('.new-hop').hide();
        $('.hop-winner').hide();
        $('.subject').val('')
    }
   else if($(select).val()==2  ){
     $('.subject').val('CONGRATULATIONS HOPPER!')
     $('.hop-winner').show();
     $('.new-hop').show();

   }
   else if($(select).val()==3){
     $('.new-hop').show();
        $('.subject').val('')
     $('.hop-winner').hide();
   }
}

function select_all(select){
    $.ajax({
        url: '/admin/messages/get_user_list.json',
        method: 'POST',
        success: function(data){
            $.each(data, function(index, value){
                $('#users_ids_').append("<option selected value=" + value.id + ">" +  value.name +"</option>");
                $('#users_ids_').trigger("liszt:updated");
            });
        },
        error: function(data){
            console.log('eror');
        }
    });
    return false;
}

