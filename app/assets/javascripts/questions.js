
$('.question-upvote').on('ajax:success', function(e, data, status, xhr) {
  $(this).html(data.count);
  if($(this).hasClass('upvoted')){
    $(this).removeClass('upvoted')
  } else {
    $(this).addClass('upvoted')
  }

  return updateCurrentUserStats();
});

$('.question-downvote').on('ajax:success', function(e, data, status, xhr) {
   $(this).html(data.count);
   if ($(this).hasClass('downvoted')) {
     $(this).removeClass('downvoted');
   } else {
     $(this).addClass('downvoted');
   }
   return updateCurrentUserStats();
 });

$('#new_question').on('ajax:success', function(e, data, status, xhr){
    $('#question_description').val("");
    $('.questions').append(xhr.responseText);
    updateCurrentUserStats();
});

$('#new_question').on('ajax:error', function(e, data, status, xhr){
    var errors = $.parseJSON(data.responseText).error
    $.each(errors, function(key, val){
        sweetAlert(val[0]);
        return false;
    });
});

$('#answer-question').on("click", function(evt){
  var id = $(this).attr("data-id");

  $('#answer-to-'+id).show();
});

$('.answer-form').on('ajax:success', function(e, data, status, xhr){
  location.reload();
});

$('.btn-cancel-form').on("click", function(evt){
  evt.preventDefault();
  $('.question-answer-form').find('.answer-form').hide();
})
