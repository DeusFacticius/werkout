json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :name, :notes, :workout_id
  json.url exercise_url(exercise, format: :json)
end
