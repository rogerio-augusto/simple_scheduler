# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "change", "#meeting_room_id", ->
  room_id = $(this).val()
  start_date = $(this).data('start-date')
  $.get('/meetings.js?room_id=' + room_id + '&start_date=' + start_date);
  return