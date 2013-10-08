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

function unsubscribe_user(sender){


    $.ajax({
        url: "/admin/users/index",
        data: { user_id: $(sender).attr('user_id'), subscribe: $(sender).attr('subscribe')},
        type: 'GET',
        beforeSend: function () {
        },
        complete: function(){
        },
        error: function(err){
            alert("error");
        },
        success: function(data){
//            $('#container').html(data);
        }
    });


}

$(document).ready(function() {
  $('.delete-user').on("click", function(e){
      if(confirm("Are you sure?")) {
          e.preventDefault();
          //user_id = $(this).closest('tr').data('id')
          tr = $(this).closest('tr')
          user_id = tr.find('td').first().text();
          $.ajax({
              type: 'DELETE',
              url: "/admin/users/delete_user/" + user_id,
              dataType: "json",
              cache: false,
              contentType: "'application/json; charset=utf-8'",
//              data: {id: user_id },
              beforeSend: function () {
              },
              error: function(xhr){
                  console.log(xhr);
                  $(tr).remove();

              },
              success: function(data){
                  $(tr).remove();
              }

          });

      }
      return false;
  });
});