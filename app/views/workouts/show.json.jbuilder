#json.extract! @workout, :id, :started_at, :ended_at, :split_name, :notes, :created_at, :updated_at
json.extract! @workout, :id, :workout_date, :time_started, :time_ended, :split_name, :notes, :created_at, :updated_at

json.exercises @workout.exercises do |e|
  json.extract! e, :id, :name, :notes, :sort_order, :updated_at, :created_at

  json.exercise_sets e.exercise_sets do |s|
    json.extract! s, :id, :weight, :reps, :target_reps, :notes, :sort_order, :updated_at, :created_at
  end
end

# TODO: Cardios
#json = @workout.to_builder