json.array!(@exercise_sets) do |exercise_set|
  json.extract! exercise_set, :id, :weight, :reps, :target_reps, :notes, :exercise_id
  json.url exercise_set_url(exercise_set, format: :json)
end
