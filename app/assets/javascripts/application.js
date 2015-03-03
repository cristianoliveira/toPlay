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
//= require bootstrap/dist/js/bootstrap
//= require foundation
//= require sweetalert/lib/sweet-alert
//= require jssor-slider/js/jssor

function flashAlert()
{
    show = function(type)
    {
      var message = $('#flash-alert-'+type).html()
      type = type.replace('default','')

      if(message)
      {
        sweetAlert({
          title: "Alert",
          text:  message,
          type: type,
          timer: 5000
        }, function(){
           $('#flash-alert-'+type).remove()
        })
        return true
      }
      return false
    };

    if (!show('default'))
       if (!show('error'))
           show('success')
}

$(function(){

  flashAlert()

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

jQuery(document).ready(function ($) {
  var options = { $AutoPlay: true };
  var jssor_slider1 = new $JssorSlider$('slider', options);
});


function uploadAvatar(){
  $('input#user_avatar').trigger('click');
};
