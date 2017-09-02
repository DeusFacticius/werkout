BASE = ''

ENDPOINTS = {
  workouts: BASE + '/workouts'
  exercises: BASE + '/exercises'
  exerciseSets: BASE + '/exercise_sets'
  cardios: BASE + '/cardios'
}

readyWrap = (req, def) ->
  $.when(def).then () -> req

saveOrUpdate = (endpoint, obj, data) ->
  isUpdate = obj?.id?
  method = if isUpdate then 'PUT' else 'POST'
  url = endpoint
  url += '/' + obj.id if isUpdate
  url += '.json'
  $.ajax({url, method, data})

api = {
  ready: jQuery.ready

  getWorkouts: () ->
    r = $.getJSON(ENDPOINTS.workouts)
    readyWrap(r, this.ready)

  getWorkout: (id, full=false) ->
    data = {}
    data.full = true if full
    r = $.getJSON(ENDPOINTS.workouts + '/' + id, data)
    readyWrap(r, this.ready)

  saveWorkout: (workout) ->
    r = saveOrUpdate(ENDPOINTS.workouts, workout, {workout})
    readyWrap(r, this.ready)

  destroyWorkout: (workout) ->
    r = $.ajax(ENDPOINTS.workouts + '/' + workout.id + '.json', {
      method: 'DELETE'
    })
    readyWrap(r, this.ready)

  getExercises: () ->
    r = $.getJSON(ENDPOINTS.exercises)
    readyWrap(r, this.ready)

  getExercisesForWorkoutId: (workoutId) ->
    r = $.getJSON(ENDPOINTS.workouts + '/' + workoutId + '/exercises')
    readyWrap(r, this.ready)

  getExercise: (id, full=false) ->
    data = {}
    data.full = true if full
    r = $.getJSON(ENDPOINTS.exercises + '/' + id)
    readyWrap(r, this.ready)

  saveExercise: (exercise) ->
    r = saveOrUpdate(ENDPOINTS.exercises, exercise, {exercise})
    readyWrap(r, this.ready)

  destroyExercise: (exercise) ->
    r = $.ajax(ENDPOINTS.exercises + '/' + exercise.id + '.json', {
      method: 'DELETE'
    })
    readyWrap(r, this.ready)

  getMostRecentSimilarExercise: (exercise) ->
    data = {
      name: exercise.name
      exclude: exercise.id
    }
    r = $.getJSON(ENDPOINTS.exercises + '/' + 'most_recent_with_name.json', data)
    readyWrap(r, this.ready)

  getExerciseSets: () ->
    r = $.getJSON(ENDPOINTS.exerciseSets)
    readyWrap(r, this.ready)

  getExerciseSetsForExerciseId: (exerciseId) ->
    r = $.getJSON(ENDPOINTS.exercises + '/' + exerciseId + '/exercise_sets')
    readyWrap(r, this.ready)

  getExerciseSet: (id) ->
    r = $.getJSON(ENDPOINTS.exerciseSets + '/' + id)
    readyWrap(r, this.ready)

  saveExerciseSet: (exerciseSet) ->
    r = saveOrUpdate(ENDPOINTS.exerciseSets, exerciseSet, {exercise_set: exerciseSet})
    readyWrap(r, this.ready)

  destroyExerciseSet: (exerciseSet) ->
    r = $.ajax(ENDPOINTS.exerciseSets + '/' + exerciseSet.id + '.json', {
      method: 'DELETE'
    })
    readyWrap(r, this.ready)

  getCardios: () ->
    r = $.getJSON(ENDPOINTS.cardios)
    readyWrap(r, this.ready)

  getCardiosForWorkoutId: (workoutId) ->
    r = $.getJSON(ENDPOINTS.workouts + '/' + workoutId + '/cardios')
    readyWrap(r, this.ready)

  saveCardio: (cardio) ->
    r = saveOrUpdate(ENDPOINTS.cardios, cardio, {cardio})
    readyWrap(r, this.ready)

  destroyCardio: (cardio) ->
    r = $.ajax(ENDPOINTS.cardios + '/' + cardio.id + '.json', {
      method: 'DELETE'
    })
    readyWrap(r, this.ready)

  getExerciseNames: () ->
    r = $.getJSON(ENDPOINTS.exercises + '/names')
    readyWrap(r, this.ready)
}

window.api = api