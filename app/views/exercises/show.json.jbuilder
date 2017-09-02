json.partial! 'exercises/exercise', exercise: @exercise

if @include_workout && @exercise.workout
  json.workout do
    json.extract! @exercise.workout, :id, :workout_date
  end
end
