$(document).on("click", '.level-menu-item', function(){

  var url        = $('#course_url').val();
  var link_url   = $('#topics_url').val();
  var course_id  = $('#course_id').val();
  var subject_id = $('#subject_id').val();
  var level_id = $(this).attr('id')

  var data = { "course_id": course_id , "subject_id": subject_id,"level_id": level_id }

  if(!$('#nav-topic').hasClass('hidden'))
    $('#nav-topic').addClass('hidden')

  $('#topics-dropdown-menu').empty();

  $.ajax({
    type: "GET",
    url: url,
    data: data,
    success: function(result){
      var topics = result.result;
      $.each(topics, function(id, topic)
      {
        $('#nav-topic').removeClass('hidden')
        var topic_url = link_url.replace('par', topic.id)
        $('#topics-dropdown-menu').append('<li role="presentation">'+
        '<a class="dropdown-menu-item topic-menu-item" href="'+topic_url+'" id="'+topic.id+'">'+topic.name+'</a></li>')
      });
    }
  });

});

$('.subject-menu-item').click(function(){

    var url        = $('#course_url').val();
    var course_id  = $('#course_id').val();
    var subject_id = $(this).attr('id')

    $('#subject_id').val(subject_id);

    var data = { "course_id": course_id , "subject_id": subject_id }

    if(!$('#nav-level').hasClass('hidden'))
      $('#nav-level').addClass('hidden')

    $('#levels-dropdown-menu').empty();

    $.ajax({
        type: "GET",
        url: url,
        data: data,
        success: function(result){
            var rows = result.result;
            $.each(rows, function(id, level)
            {
                $('#nav-level').removeClass('hidden')
                $('#levels-dropdown-menu').append('<li role="presentation"><a class="dropdown-menu-item level-menu-item" href="#subject_'+id+'" id="'+level.id+'">'+level.name+'</a></li>')
            });
        }
    });

});

$(".enter-to-click").mouseenter(function(event){
  $(this).click();
})
