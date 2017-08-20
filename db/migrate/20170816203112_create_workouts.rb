class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.date     :workout_date, null: false
      t.time     :time_started
      t.time     :time_ended
      t.string :split_name
      t.text :notes

      t.timestamps null: false
    end
  end
end
