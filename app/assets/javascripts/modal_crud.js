var ModalCRUD = (function (exception_field_id) {

    var modal_crud = function (init_data) {
        this.new_path = init_data.new_path;
        this.index_path = init_data.index_path;
        this.list_id = init_data.list_id;
        exception_field_id = init_data.exception_field_id;
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
                setAjaxPagination(name);
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

    //pagination
    function setAjaxPagination(name){
        $('#modal-crud-window .pagination a').click(function(){
            console.log('-----------------------------------------');
            console.log(exception_field_id);
            console.log($('.chzn-select#' + exception_field_id));
            console.log($('.chzn-select#' + exception_field_id).val());

            console.log('-----------------------------------------');
            var params = {selected_hops: $('.chzn-select#' + exception_field_id).val() };
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
    }

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
