// require votable
// require header_menu
// require user_exercise_answer

$('.edit_resume_action').hide();
$('#cke_resume_description').hide();
$('#display_description').show();

openToEdit = function(open){
    if(open)
    {
        $('#cke_resume_description').show();
        $('#btn_send_resume').show();
        $('#display_description').hide();

        CKEDITOR.config.removePlugins= 'toolbar'
        CKEDITOR.replace('resume_description');
    }
    else
    {
        $('#cke_resume_description').hide();
        $('#display_description').show();
        $('#btn_send_resume').hide();
    }
}

$('#edit_resume_pen').on('click', function(event){
    event.preventDefault();

    openToEdit(!$('#cke_resume_description').is(":visible"));
})

$('#resume_form').on('ajax:success', function(e, data, status, xhr){
    $('#display_description').html(data.description);
    openToEdit(false);
})
