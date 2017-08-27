# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
#
#app = new Vue({
#  el: '#app-root',
#  data: {
#    workouts: []
#  },
#  created: () ->
#    self = this
#    $.getJSON('/workouts').done (data) ->
#      console.log("Workout data: ", data)
#      self.workouts = data
#})

this.wapp = null
this.getMyData = () ->
  $.getJSON("#{workout_path(@workout)}").then (data,jsxhr) ->
    window.myData = data.workout

Vue.component('workout', {
  template: '#workout-template',
  props: ['workout']
})

Vue.component('exercise-set', {
  template: '#eset-template',
  props: ['eset'],
  computed: {
    isSuccess: () ->
      this.eset.target_reps && this.eset.reps >= this.eset.target_reps
    isWeighted: () ->
      this.eset.weight
  }
})
Vue.component('exercise', {
  template: '#exercise-template',
  props: ['exercise']
})
this.doMyInit = (path) ->
  window.wapp = new Vue({
    el: '#workout-root',
    data: {
      workout: {
        workout_date: null,
        time_started: null,
        time_ended: null,
        exercises: [],
        cardios: [],
        notes: null
      },
      exercise_names: []
    },
    methods: {
      addExercise: (event) ->
        console.log("Adding exercise...", event)
        data = {
          exercise: {
            workout_id: this.workout.id,
            name: $('#name-input').val()
          }
        }
        self = this
        $.post('/exercises.json', data).done( (resp, jqxhr) ->
          console.log("Exercise created: ", resp)
          self.workout.exercises.push(resp)
        ).fail (resp,jqxhr) ->
          console.log("Exercise create failed: ", resp)
      showAddExerciseModal: (event) ->
        console.log("Showing add exercise modal...", event)
        $('#enter-name-modal').modal()

      destroyExercise: (event, exercise) ->
        console.log("Destroy exercise: ", exercise, event)
        index = this.workout.exercises.indexOf(exercise)
        console.log("Found at index: ", index)

    },
    created: () ->
      self = this
      $.getJSON(path, {full: true}).then (data,jsxhr) ->
        self.workout = data
      $.getJSON('/exercises/names').then (data, jsxhr) ->
        self.exercise_names = data
        $('#name-input').autocomplete({ source: self.exercise_names })
      # Register event listeners
      console.log("Registering event listeners...")
      this.$on('my.destroy.exercise', this.destroyExercise)
      console.log("Event listeners registered.")

  })
#$(doMyInit)