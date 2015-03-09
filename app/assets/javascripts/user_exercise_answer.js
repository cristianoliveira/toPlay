$('.exercise_answer_form').on('ajax:success', function(e, data, status, xhr){
    var answer = data.result

    if(answer.is_correct_answer)
      swal("Good job!", "Você acertou!", "success")
    else
      swal("Sorry!", "Você errou", "error")

});

$('.exercise_answer_form').on('ajax:error', function(e, data, status, xhr){
    sweetAlert('Error.'+data.error);
});
