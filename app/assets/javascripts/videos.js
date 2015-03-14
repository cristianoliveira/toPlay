ajaxRefreshSelect = function(select_to_refresh, url, data){
    $.ajax({
        type: "GET",
        url: url,
        data: data,
        success: function(result){
          $(select_to_refresh).append('<option value="0"></option>')
          for(i = 0; i < result.length; i++)
          {
            $(select_to_refresh).append('<option value="' + result[i].id + '">' + result[i].name + '</option>')
          }
        }
    });

};

$('#course-select').change(function(event){
  var id = $(this).val();
  var url = $(this).attr('data-url');

  ajaxRefreshSelect("#level-select", url, { 'course_id': id });
});

$('#level-select').change(function(event){
  var id = $(this).val();
  var url = $(this).attr('data-url');

  ajaxRefreshSelect("#topic-select", url, { 'level_id': id });
});

$('#video-form').on('ajax:success', function(e, data, status, xhr){
   sweetAlert('Video enviado enviada.');
   window.location.replace(data.redirect_to);
});

$('#video-form').on('ajax:error', function(e, data, status, xhr){
  var formatted_error = '';
  var list_errors = $.parseJSON(data.responseText)

  for(i=0; i < list_errors.length; i++)
  {
      formatted_error += '<li>' + list_errors[i] + '</li>'
  }

  swal({ html: true,
         title: "Validação",
         text: formatted_error,
         type: 'error',
         timer: 5000 });
});
