# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->

  $(".topic .sidebar").stick_in_parent offset_top: 20
  .on "sticky_kit:stick", (e) ->
    $(e.target).parent().css 'width', ->
      166

  $(".topic .sidebar .tabs a").click ->
    $(".topic .sidebar dd").removeClass 'active'
    $(this).parent().addClass 'active'
    $("body,html").animate
      scrollTop: $($(this).attr("href")).position().top - 15
    , 800
    false

  $('.exercise-navigation').css 'width', ->
    $(this).find 'li'
    .size() * 40

$('.exercises .alternative')
.on 'click', (event) ->
  event.preventDefault()
  $(".exercises .alternatives-for-#{$(this).attr('data-exercise')} a").removeClass 'active'

  answer = $(this).attr 'data-answer'
  $(this).addClass 'active'
  $('.get_answer').attr 'data-answer', ->
    answer

$('.exercises')
.on 'after-slide-change.fndtn.orbit', (event, orbit) ->
  exercise = orbit.slide_number + 1

  $(".exercise-navigation li:nth-child(-n + #{exercise}) a").addClass 'active'
  $(".exercise-navigation li:nth-child(n + #{(exercise + 1)}) a").removeClass 'active'


$('.get_answer')
.on 'click', (event) ->
  event.preventDefault()
  $.ajax
    url: "/exercise/#{$(this).attr('data-exercise')}/get_answer/#{$(this).attr('data-answer')}",
    type: "get"
    dataType: "json"
    complete: (data) ->
      if data.responseJSON.is_correct
      else
        $( ".get_answer" ).effect('shake');
      return