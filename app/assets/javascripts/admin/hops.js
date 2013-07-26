function progressHandlingFunction(e){
    if(e.lengthComputable){
//        $('progress').attr({value:e.loaded,max:e.total});
    }
}


//tasks

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

//ads

function newAdModal(hop_id){
    $.ajax({
        url: '/admin/ads/new?hop_id=' + hop_id,
        data: null,
        type: 'GET',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#new-ad-modal').find('.modal-body').html(data);
            $('#new-ad-modal').modal();
        }
    });
}

function submitAdForm(hop_id){
    var formData = new FormData($('#new-ad-modal form')[0]);
    $.ajax({
        url: '/admin/ads',
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
                updateAdTable(hop_id);
                $('#new-ad-modal').modal('hide');
            } else {
                $('#new-ad-modal').find('.modal-body').html(data);
            }
        }
    });
}

function updateAdTable(hop_id){
    $.ajax({
        url: '/admin/ads/regular_hop_ads',
        data: {hop_id: hop_id},
        type: 'GET',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#adsTable').html(data);
        }
    });
}