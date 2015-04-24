// Modal form alternative changes
$('.modal-form').on("click", 'a.correct-alternative', function(event){
  event.preventDefault();

  // Change all to false
  $('.correct-alternative').removeClass('correct');

  $(this).addClass('correct');
  $(this).find('input').prop('checked', true)

});

$('.modal-form').on('ajax:success', '#edit-exercises form', function(e, data, status, xhr){
  swal({title: "Exercicio",
        text: "Salvando...",
        imageUrl: "/assets/loading.gif" });
  window.location.reload();
});

//Form to awnser in topic view
$('.exercise-answer-form').on('ajax:success', function(e, data, status, xhr){
    var answer = data.result

    if(answer.is_correct_answer)
      swal("Good job!", "Você acertou!", "success")
    else
      swal("Sorry!", "Você errou", "error")

    updateCurrentUserStats();

});

$('.exercise-answer-form').on('ajax:error', function(e, data, status, xhr){
    sweetAlert('Error.'+data.error);
});

$('.exercise-answer-form').on('click','a.answer-alternatives', function(event){
  event.preventDefault();

  $('.answer-alternatives').find('span').removeClass('selected-answer');

  $(this).find('span').addClass('selected-answer');
  $(this).find('input').prop('checked', true)
})

$('.exercises').on('after-slide-change.fndtn.orbit', function(event, orbit){
  exercise = orbit.slide_number + 2

  $(".exercise-navigation a").removeClass('active')
  $(".exercise-navigation li:nth-child("+ exercise +") a").addClass('active')
});
