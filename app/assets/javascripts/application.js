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
//= require ckeditor/init
//= require_tree

$(window).on("scroll",function(){
  if ($(document).scrollTop() > 200)
  {
    $('header').addClass('header-small')
  }
  else
  {
    $('header').removeClass('header-small')
  }
})

function uploadAvatar(){
  $('input#user_avatar').trigger('click');
};

function updateCurrentUserStats(){
  var url = $('#user-stats').attr('data-url');

  $.ajax({
    type: "GET",
    url: url,
    dataType: "json",
    success: function(data){
      $('#user-points').html(data.result.points)
    }
  })


}
