function setAjaxPagination(){
    $('.pagination a').attr('href', '#');
    $('.pagination a').click(function(){
//        j.ajax({
//            url: $(document).attr('href'),
//            data: {data: 'df'},
//            type: 'GET',
//            beforeSend: function () {
//            },
//            complete: function(){
//            },
//            error: function(err){
//                alert("error");
//            },
//            success: function(data){
//                alert(data)
//            }
//        });
        return false;
    });
}

$(document).ready(function(){
    setAjaxPagination();
});
