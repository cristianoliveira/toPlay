// require votable
// require header_menu
// require user_exercise_answer     
//= require ckeditor/ckeditor

$('#new_question').on('ajax:success', function(e, data, status, xhr){
    sweetAlert('Pergunta enviada.');
    $('#question_description').val("");
    $('.questions').append(xhr.responseText);
});

$('#new_question').on('ajax:error', function(e, data, status, xhr){
    var errors = $.parseJSON(data.responseText).error
    $.each(errors, function(key, val){
        sweetAlert(val[0]);
        return false;
    });
});

openToEdit = function(open)
{
    if(open)
    {
        $('.edit_resume_action').removeClass('hidden');
        $('#cke_resume_description').removeClass('hidden');
        $('#display_description').addClass('hidden');

        CKEDITOR.config.removePlugins= 'toolbar'
        CKEDITOR.replace( 'resume_description');
    }
    else
    {
        $('.edit_resume_action').addClass('hidden');
        $('#cke_resume_description').addClass('hidden');
        $('#display_description').removeClass('hidden');
    }
}

$('#edit_resume_pen').on('click', function(event){
    event.preventDefault();

    openToEdit($('.edit_resume_action').hasClass('hidden'));
})

$('#resume_form').on('ajax:success', function(e, data, status, xhr){
    $('#display_description').html(data.description);
    openToEdit(false);
})
