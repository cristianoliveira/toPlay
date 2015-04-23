// Modal form alternative changes
$('.modal-form').on("click", 'a.correct-alternative', function(event){
  event.preventDefault();

  // Change all to false
  $('.correct-alternative').removeClass('correct');

  $(this).addClass('correct');
  $(this).find('input').prop('checked', true)

});

$('#exercise-form').on('ajax:success', function(e, data, status, xhr){
  swal({title: "Exercise",
        text: "Salvando...",
        imageUrl: "/assets/loading.gif" });
  window.location.reload();
});
