json.array!(@workouts) do |workout|
  json.extract! workout, :id, :workout_date, :time_started, :time_ended, :split_name, :notes
  json.url workout_url(workout, format: :json)
end
