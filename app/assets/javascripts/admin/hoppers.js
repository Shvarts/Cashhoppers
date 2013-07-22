function show_modal_hop(element,url,partial) {

    $.ajax({
        url: url,
        dataType: 'text',
        data: null,
        type: 'GET',
        beforeSend: function () {
            //start spinner
        },
        complete: function(){
            //stop_spinner
        },
//            error: function(err){
//                alert("error");
//            },
        success: function(data){
            $(element).html(data);
            setAjaxPagination(partial);

        }
    });
    return false;
}

$(function() {
    $('#find_hop').click(function(){

        show_modal_hop('#myModalhop','/admin/messages/find_hop', 'hops_list');
    })
    $('#find_zip').click(function(){

        show_modal_hop('#myModalzip','/admin/messages/find_zip','zips_list');
    })
});



function setAjaxPagination(block_id){
    $('#' + block_id + ' .pagination a').click(function(){
        $.ajax({
            url: $(this).attr('href'),
            dataType: 'text',
            data: null,
            type: 'GET',
            beforeSend: function () {
                //start spinner
            },
            complete: function(){
                //stop_spinner
            },
//            error: function(err){
//                alert("error");
//            },
            success: function(data){
                $('#' + block_id).html(data);
                setAjaxPagination(block_id);
            }
        });
        return false;
    });
    $('#' + block_id + ' #search_button').click(function(){
        $.ajax({
            url: $(this).attr('href'),
            dataType: 'text',
            data: {query: $('#' + block_id + ' #search_field').val()},
            type: 'GET',
            beforeSend: function () {
                //start spinner
            },
            complete: function(){
                //stop_spinner
            },
            error: function(err){
                alert("error");
            },
            success: function(data){
                $('#' + block_id).html(data);
                setAjaxPagination(block_id);
            }
        });
        return false;
    });
    $('#' + block_id + ' #select_id').click(function(){
        $.ajax({
            url: $(this).attr('href'),
            dataType: 'text',
            data: null,
            type: 'GET',
            beforeSend: function () {
                //start spinner
            },
            complete: function(){
                //stop_spinner
            },
//            error: function(err){
//                alert("error");
//            },
            success: function(data){
                $('#' + block_id).html(data);
                setAjaxPagination(block_id);
            }
        });
        return false;
    });
}

$(document).ready(function(){
    setAjaxPagination('users_list');
});
