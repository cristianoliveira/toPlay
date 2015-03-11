//= require ckeditor/ckeditor
// require votable
// require header_menu
// require user_exercise_answer

$('.edit_resume_action').hide();
$('#cke_resume_description').hide();
$('#display_description').show();


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
        $('.edit_resume_action').show();
        $('#cke_resume_description').show();
        $('#display_description').hide();

        CKEDITOR.config.removePlugins= 'toolbar'
        CKEDITOR.replace( 'resume_description');
    }
    else
    {
        $('.edit_resume_action').hide();
        $('#cke_resume_description').hide();
        $('#display_description').show();
    }
}

$('#edit_resume_pen').on('click', function(event){
    event.preventDefault();

    openToEdit(!$('.edit_resume_action').is(":visible"));
})

$('#resume_form').on('ajax:success', function(e, data, status, xhr){
    $('#display_description').html(data.description);
    openToEdit(false);
})
