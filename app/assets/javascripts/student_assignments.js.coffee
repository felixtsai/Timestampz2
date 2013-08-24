# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#due_date').datepicker({ dateFormat: 'yy-mm-dd' })
  $('#change_date').on('click', ->
    $('#comments').before("<label for='student_assignment_completion_date'>Completion date</label>")
    $('#comments').before("<input id='student_assignment_due_date' type='text' placeholder='Enter Date' name='student_assignment_due_date]'><br>")
    $('#student_assignment_due_date').datepicker({ dateFormat: 'yy-mm-dd' })
    $('#change_date').hide()
    ) # end on
