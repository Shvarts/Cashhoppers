function change_user_role(sender){
    if(!confirm("Are you sure you want to change user role ?")){
        return;
    }
    $.ajax({
        url: "change_user_role",
        data: { user_id: $(sender).attr('user_id'), new_role_id: $(sender).val()},
        type: 'POST',
        beforeSend: function () {
        },
        complete: function(){
        },
        error: function(err){
            alert("error");
        },
        success: function(data){
            alert(data);
        }
    });


}