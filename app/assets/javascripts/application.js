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

$('.small-menu').hide()
$('.menu-courses').hide()

$(window).on("scroll",function(){
  if ($(document).scrollTop() > 200)
  {
    $('.links').hide()
    $('.small-menu').show()
    $('.menu-courses').show()
    $('header').addClass('header-small')
  }
  else
  {
    $('.links').show()
    $('.small-menu').hide()
    $('.menu-courses').hide()
    $('header').removeClass('header-small')
  }
})

function clickOn(id)
{
  $(id).trigger('click');
}

function uploadAvatar(){
  clickOn('input#user_avatar');
  // $('input#user_avatar').trigger('click');
};

function updateCurrentUserStats(){
  var url = $('#user-stats').attr('data-url');
  var topic_id = $('#topic_id').val();
  $.ajax({
    type: "GET",
    url: url,
    data: { "topic_id": topic_id },
    dataType: "json",
    success: function(data){
      user_stats = data.result
      $('#user-points').html(user_stats.total_points)
      $('#user-topic-points').html(user_stats.topic_points)
    }
  })


}
