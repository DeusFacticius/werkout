json.extract! exercise, :id, :name, :notes, :workout_id, :created_at, :updated_at

if exercise.exercise_sets.loaded?
  json.exercise_sets do
    json.array! exercise.exercise_sets, partial: 'exercise_sets/exercise_set', as: :exercise_set
  end
end