# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# pending: spike meeting rooms
# $(document).on "change", "#meeting_room_id", ->
#   room_id = $(this).val()
#   start_date = $(this).data('start-date')
#   $.get('/meetings.js?room_id=' + room_id + '&start_date=' + start_date);
#   return
  
$(document).on "click", ".create-meeting", ->
  starts_at = $(this).data('starts-at')
  $('#meeting_starts_at').val(starts_at);
  $('#new_meeting').submit();
  return