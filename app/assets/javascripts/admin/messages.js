$(function(){

    $('div#datetimepicker1').css('display', 'none');
 $('input#schedule').click(function(){
   if ($(this).is(':checked')   ){
       $('div#datetimepicker1').css('display', 'block');}
   else{
       $('div#datetimepicker1').css('display', 'none'); }
  });
});





$(document).ready(function(){



   $('.chzn-select').chosen();

    modal_window('#find_user_chzn', '#myModal') ;
    modal_window('#find_hop_chzn', '#myModalhop') ;
    modal_window('#find_zip_chzn', '#myModalzip') ;

    ajaxSearch('#users_list .pagination a',{},'#users_list');
    ajaxSearch('#hops_list .pagination a',{},'#hops_list');
    ajaxSearch('#zips_list .pagination a',{},'#zips_list');

    ajaxSearch('#users_list #search_button',{query: function (){ return $('#users_list #search_field').val();}},'#users_list');
    ajaxSearch('#hops_list #search_button',{query: function (){ return $('#hops_list #search_field').val();}}, '#hops_list');
    ajaxSearch('#zips_list #search_button',{query: function (){ return $('#zips_list #search_field').val();}}, '#zips_list');


    add_select_click('#users_list #select_id', '#find_user');
    add_select_click('#hops_list #select_id', '#find_hop');
    add_select_click('#zips_list #select_id', '#find_zip');


    $('#myModal,#myModalzip, #myModalhop').on('hidden', function () {
        $('.chzn-select').trigger("liszt:updated");
    });

    $('#myModal,#myModalzip, #myModalhop').on('show', function () {
        $('.chzn-select').trigger("liszt:updated");
        clearOptions();
    });
});

function clearOptions(){
    $('.chzn-select option').remove();
    $('.chzn-select').trigger("liszt:updated");
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

function add_select_click(url, input_id){
    $(document).on('click', url , function(){

        var user_id = $(this).data("user-id");
        if($('.chzn-select option[value=' + user_id + ']').size() == 0){
            $(input_id).append("<option selected value=" + user_id + ">" + user_id +"</option>");
        }
        return false;
    });

};


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
  $(document).on('click', url, function(){

     $( window_id).modal();

      if(window_id == '#myModalhop' ){
          show_modal_hop('#myModalhop','/admin/messages/find_hop', 'hops_list');

      }
      else if(window_id == '#myModalzip' ){
          show_modal_hop('#myModalzip','/admin/messages/find_zip', 'zips_list');
      }

  }) ;
};