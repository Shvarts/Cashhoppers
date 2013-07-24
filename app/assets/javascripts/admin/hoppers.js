$(document).ready(function(){


    modal_window('#findName','#myModalname');
    modal_window('#findId','#myModalid');

    ajaxSearch('#names_list .pagination a',{},'#names_list');
    ajaxSearch('#ids_list .pagination a',{},'#ids_list');

    ajaxSearch('#names_list #search_button',{query: function (){ return $('#names_list #search_field').val();}},'#names_list');
    ajaxSearch('#ids_list #search_button',{query: function (){ return $('#ids_list #search_field').val();}}, '#ids_list');


}) ;

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
        error: function(err){
            alert("error");
        },
        success: function(data){
            $(element).html(data);
        }
    });
    return false;
};

function modal_window(url, window_id){
    $(document).on('click', url , function(){

        $( window_id).modal();

        if(window_id == '#myModalname' ){
            show_modal_hop('#myModalname','/admin/hoppers/search_by_name', 'names_list');
        }
        else if(window_id == '#myModalid' ){
            show_modal_hop('#myModalid','/admin/hoppers/search_by_id', 'id_list');
        }

    }) ;
}



function ajaxSearch(selector, data, list){

    $(document).on('click', selector, function(e){


        var aj_data = data.query ? {query: data.query()} : null
        e.preventDefault();
        $.ajax({
            url: $(this).attr('href'),
            dataType: 'text',
            data: aj_data,
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
                $(list).html(data);
            }
        });
        return false;
    });
};