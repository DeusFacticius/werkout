json.array!(@cardios) do |cardio|
  json.extract! cardio, :id, :name, :duration, :resistance_level, :notes, :distance, :calories, :workout_id
  json.url cardio_url(cardio, format: :json)
end
