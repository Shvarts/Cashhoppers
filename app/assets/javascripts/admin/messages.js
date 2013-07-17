$(function(){
    $('div#datetimepicker1').css('display', 'none');
 $('input#schedule').click(function(){
   if ($(this).is(':checked')   ){
       $('div#datetimepicker1').css('display', 'block');}
   else{
       $('div#datetimepicker1').css('display', 'none'); }
  });
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
            data: {query: $('#' + block_id + ' #search_field').val(), id: $('#' + block_id + ' #by_id').is(':checked'), hop: $('#' + block_id + ' #by_hop').is(':checked')},
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

