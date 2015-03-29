  $('.question-upvote')
  .on 'ajax:success', (e, data, status, xhr) ->
    $(this).html(data.count)
    if $(this).hasClass('upvoted')
      $(this).removeClass('upvoted')
    else
      $(this).addClass('upvoted')
    updateCurrentUserStats()

  $('.question-downvote')
  .on 'ajax:success', (e, data, status, xhr) ->
    $(this).html(data.count);
    if $(this).hasClass('downvoted')
      $(this).removeClass('downvoted')
    else
      $(this).addClass('downvoted')
    updateCurrentUserStats()
