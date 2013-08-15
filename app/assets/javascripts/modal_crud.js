var ModalCRUD = (function () {

    this.exception_field_id = '';
    this.new_path = '';
    this.index_path = '';
    this.list_id = '';

    this.modal_crud = function (init_data) {
        this.new_path = init_data.new_path;
        this.index_path = init_data.index_path;
        this.list_id = init_data.list_id;
        this.exception_field_id = init_data.exception_field_id;
    };

    var progressHandlingFunction = function(e){
        if(e.lengthComputable){
//        $('progress').attr({value:e.loaded,max:e.total});
        }
    };

    this.loadPartial = function(url, params, name){
        exception_field_id = this.exception_field_id;
        $.ajax({
            url: url,
            data: params,
            type: 'GET',
            error: function(err){
                alert(url);
                alert("error");
            },
            success: function(data){
                $('#modal-crud-window').find('.modal-body').html(data);
                $('#modal-crud-window').find('#modal-crud-label').html(name);
                setAjaxPagination(name, exception_field_id);
                if($('#modal-crud-window').css('display') == 'none'){
                    $('#modal-crud-window').modal();
                }
            }
        });
    };

    this.newRecord = function(params, name){
        loadPartial(this.new_path, params, name);
    };

    this.editRecord = function(params, name, edit_path){
        loadPartial(edit_path, params, name);
    };


    this.submitForm = function(params){
        var index_path = this.index_path;
        var list_id = this.list_id;
        var my_form = $('#modal-crud-window form');
        var formData = new FormData(my_form[0]);

        var modal_crud = this;
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
                    modal_crud.updateTable(params);
                    $('#modal-crud-window').modal('hide');
                } else {
                    $('#modal-crud-window').find('.modal-body').html(data);
                }
            }
        });
    };

    this.updateTable = function(params){
        var index_path = this.index_path;
        var list_id = this.list_id;
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

    this.removeRecord = function(url, params){
        var index_path = this.index_path;
        var list_id = this.list_id;
        var modal_crud = this;
        if(confirm('Are you sure?')){
            $.ajax({
                url: url,
                type: 'DELETE',
                error: function(err){
                    alert("error");
                },
                success: function(data){
                    if(data == 'ok'){
                        modal_crud.updateTable(params);
                    }else{
                        alert('error');
                    }
                }
            });
        }
    };
   this.rejectRecord= function(url, params){
        var index_path = this.index_path;
        var list_id = this.list_id;
       var modal_crud = this;
        if(confirm('Are you sure?')){
            $.ajax({
                url: url,
                type: 'PUT',
                error: function(err){
                    alert("error");
                },
                success: function(data){
                    if(data == 'ok'){
                        modal_crud.updateTable(params);

                    }else{
                        alert('error');
                    }
                }
            });
        }
    };
   this.rundomeaRecord = function(url, params){
        var index_path = this.index_path;
        var list_id = this.list_id;
       var modal_crud = this;
        if(confirm('Are you sure?')){
            $.ajax({
                url: url,
                type: 'POST',
                error: function(err){
                    alert("error");
                },
                success: function(data){
                    if(data == 'ok'){
                        modal_crud.updateTable(params);
                    }else{
                        alert('error');
                    }
                }
            });
        }
    };
//
    //pagination
    this.setAjaxPagination = function(name, exception_field_id){
        $('#modal-crud-window .pagination a').click(function(){
            if(exception_field_id == 'hops_ids_'){
                var params = {selected_hops: $('.chzn-select#' + exception_field_id).val() };
            }
            if(exception_field_id == 'users_ids_'){
                var params = {selected_users: $('.chzn-select#' + exception_field_id).val() };
            }
            loadPartial($(this).attr('href'), params, name);
            return false;
        });

//        $('#' + block_id + ' #search_button').click(function(){
//            $.ajax({
//                url: $(this).attr('href'),
//                dataType: 'text',
//                data: {query: $('#' + block_id + ' #search_field').val()},
//                type: 'GET',
//                beforeSend: function () {
//                    //start spinner
//                },
//                complete: function(){
//                    //stop_spinner
//                },
//                error: function(err){
//                    alert("error");
//                },
//                success: function(data){
//                    $('#' + block_id).html(data);
//                    setAjaxPagination(block_id);
//                }
//            });
//            return false;
//        });
    };

    // prototype
    modal_crud.prototype = {
        constructor:    modal_crud,
       rejectRecord:    rejectRecord,
        loadPartial:    loadPartial,
        rundomeaRecord: rundomeaRecord,
        newRecord:      newRecord,
        editRecord:     editRecord,
        submitForm:     submitForm,
        updateTable:    updateTable,
        removeRecord:   removeRecord,
        setAjaxPagination: setAjaxPagination
    };

    return modal_crud;
})();

$(document).ready(function(){
    $('.modal-body').css('max-height', $('.modal').css('height'));
});
