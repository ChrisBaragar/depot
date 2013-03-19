# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# On page load/change...
$(document).on "page:change", ->
# When any image is clicked...
	$('.store .entry > img').click ->
# The parent of the element that was clicked, find submit button and click it.
		$(this).parent().find(':submit').click()