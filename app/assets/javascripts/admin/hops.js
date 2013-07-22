function newTaskModal(hop_id){
    $.ajax({
        url: '/admin/hop_tasks/new?hop_id=' + hop_id,
        data: null,
        type: 'GET',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#new-task-modal').find('.modal-body').html(data);
            $('#new-task-modal').modal();
        }
    });
}

function submitTaskForm(hop_id){
    var formData = new FormData($('#new-task-modal form')[0]);
    $.ajax({
        url: '/admin/hop_tasks',
        data: formData,
        xhr: function() {
            var myXhr = $.ajaxSettings.xhr();
            if(myXhr.upload){
                myXhr.upload.addEventListener('progress',progressHandlingFunction, false);
            }
            return myXhr;
        },
        type: 'POST',
        cache: false,
        contentType: false,
        processData: false,
        error: function(err){
            alert("error");
        },
        success: function(data){
            if(data == 'ok'){
                updateTaskTable(hop_id);
                $('#new-task-modal').modal('hide');
            } else {
                $('#new-task-modal').find('.modal-body').html(data);
            }
        }
    });
}

function progressHandlingFunction(e){
    if(e.lengthComputable){
//        $('progress').attr({value:e.loaded,max:e.total});
    }
}

function updateTaskTable(hop_id){
    $.ajax({
        url: '/admin/hop_tasks',
        data: {hop_id: hop_id},
        type: 'GET',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#tasksTable').html(data);
        }
    });
}