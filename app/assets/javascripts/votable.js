$(function(){

    $(document).foundation();

    upvote = function(e, data, status, xhr) {
        $(this).html(data.count);
        if ($(this).hasClass('upvoted'))
          $(this).removeClass('upvoted');
        else
          $(this).addClass('upvoted');

        updateCurrentUserStats();
    }

    dowvote = function(e, data, status, xhr) {
        $(this).html(data.count);
        if ($(this).hasClass('downvoted'))
          $(this).removeClass('downvoted');
        else
          $(this).addClass('downvoted');

        updateCurrentUserStats();
    }


    $('.downvote').on('ajax:success', dowvote);

    $('.upvote').on('ajax:success', upvote);

});
