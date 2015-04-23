// Modal form alternative changes
$('.modal-form').on("click", 'a.correct-alternative', function(event){
  event.preventDefault();

  // Change all to false
  $('.correct-alternative').removeClass('correct');

  $(this).addClass('correct');
  $(this).find('input').prop('checked', true)

});

$('.modal-form').on('ajax:success', '#edit-exercises form', function(e, data, status, xhr){
  swal({title: "Exercise",
        text: "Salvando...",
        imageUrl: "/assets/loading.gif" });
  window.location.reload();
});
