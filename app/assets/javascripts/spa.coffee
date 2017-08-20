# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

app = new Vue({
  el: '#app-root',
  data: {
    workouts: []
  },
  created: () ->
    self = this
    $.getJSON('/workouts').done (data) ->
      console.log("Workout data: ", data)
      self.workouts = data
})
