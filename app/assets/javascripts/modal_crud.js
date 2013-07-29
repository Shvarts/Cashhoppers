var ModalCRUD = (function () {

    var modal_crud = function (init_data) {
        this.new_path = init_data.new_path;
        this.index_path = init_data.index_path;
        this.list_id = init_data.list_id;
    };

    var progressHandlingFunction = function(e){
        if(e.lengthComputable){
//        $('progress').attr({value:e.loaded,max:e.total});
        }
    };

    var loadPartial = function(url, params, name){
        $.ajax({
            url: url,
            data: params,
            type: 'GET',
            error: function(err){
                alert("error");
            },
            success: function(data){
                $('#modal-crud-window').find('.modal-body').html(data);
                $('#modal-crud-window').find('#modal-crud-label').html(name);
                $('#modal-crud-window').modal();
            }
        });
    };

    var newRecord = function(params, name){
        loadPartial(this.new_path, params, name);
    };

    var editRecord = function(params, name, edit_path){
        loadPartial(edit_path, params, name);
    };

    var submitForm = function(params){
        var index_path = this.index_path;
        var list_id = this.list_id;
        var my_form = $('#modal-crud-window form');
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
                    updateTable(params, index_path, list_id);
                    $('#modal-crud-window').modal('hide');
                } else {
                    $('#modal-crud-window').find('.modal-body').html(data);
                }
            }
        });
    };

    var updateTable = function(params, index_path, list_id){
        $.ajax({
            url: index_path,
            data: params,
            type: 'GET',
            contentType: 'text',
            error: function(err){
                alert("error");
            },
            success: function(data){
                $('#'+list_id).html(data);
            }
        });
    };

    var removeRecord = function(url, params){
        var index_path = this.index_path;
        var list_id = this.list_id;
        if(confirm('Are you sure?')){
            $.ajax({
                url: url,
                type: 'DELETE',
                error: function(err){
                    alert("error");
                },
                success: function(data){
                    if(data == 'ok'){
                        updateTable(params, index_path, list_id);
                    }else{
                        alert('error');
                    }
                }
            });
        }
    };

    // prototype
    modal_crud.prototype = {
        constructor:    modal_crud,
        loadPartial:    loadPartial,
        newRecord:      newRecord,
        editRecord:     editRecord,
        submitForm:     submitForm,
        removeRecord:   removeRecord
    };

    return modal_crud;
})();
