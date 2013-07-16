$(function(){
    $('div#datetimepicker1').css('display', 'none');
 $('input#schedule').click(function(){
   if ($(this).is(':checked')   ){
       $('div#datetimepicker1').css('display', 'block');}
   else{
       $('div#datetimepicker1').css('display', 'none'); }
  });
});


