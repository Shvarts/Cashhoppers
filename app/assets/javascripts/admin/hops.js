function progressHandlingFunction(e){
    if(e.lengthComputable){
//        $('progress').attr({value:e.loaded,max:e.total});
    }
}

function loadForm(hop_id, url, target_id){
    $.ajax({
        url: url + '?hop_id=' + hop_id,
        data: null,
        type: 'GET',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#' + target_id).find('.modal-body').html(data);
            $('#' + target_id).modal();
        }
    });
}

function submitForm(hop_id, target_id, list_url, list_id){
    var my_form = $('#'+target_id+' form');
    var formData = new FormData(my_form[0]);
    $.ajax({
        url: my_form.attr('action'),
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
                updateTable(list_url, list_id, hop_id);
                $('#'+target_id).modal('hide');
            } else {
                $('#'+target_id).find('.modal-body').html(data);
            }
        }
    });
}

function updateTable(list_url, list_id, hop_id){
    $.ajax({
        url: list_url,
        data: {hop_id: hop_id},
        type: 'GET',
        error: function(err){
            alert("error");
        },
        success: function(data){
            $('#'+list_id).html(data);
        }
    });
}

function removeRecord(url, list_url, list_id, hop_id){
    if(confirm('Are you sure?')){
        $.ajax({
            url: url,
            type: 'DELETE',
            error: function(err){
                alert("error");
            },
            success: function(data){
                if(data == 'ok'){
                    updateTable(list_url, list_id, hop_id);
                }else{
                    alert('error');
                }
            }
        });
    }
}