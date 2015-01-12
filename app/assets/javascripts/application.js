// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(function(){
  $(document).foundation();

  $('.date_field').mask('00/00/0000');

  $('.video-upvote').on('ajax:success', function(e, data, status, xhr) {
    $(this).html(data.count);
    if ($(this).hasClass('upvoted'))
      $(this).removeClass('upvoted');
    else
      $(this).addClass('upvoted');
  });

  $('.video-downvote').on('ajax:success', function(e, data, status, xhr) {
    $(this).html(data.count);
    if ($(this).hasClass('downvoted'))
      $(this).removeClass('downvoted');
    else
      $(this).addClass('downvoted');
  });

});

function uploadAvatar(){
  $('input#user_avatar').trigger('click');
};