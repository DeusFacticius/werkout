json.extract! workout, :id, :workout_date, :time_started, :time_ended, :split_name, :notes, :created_at, :updated_at

if workout.exercises.loaded?
  json.exercises do
    json.array! workout.exercises, partial: 'exercises/exercise', as: :exercise
  end
end

if workout.cardios.loaded?
  json.cardios do
    json.array! workout.cardios, partial: 'cardios/cardio', as: :cardio
  end
end