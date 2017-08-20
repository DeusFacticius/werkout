class CreateExerciseSets < ActiveRecord::Migration
  def change
    create_table :exercise_sets do |t|
      t.decimal :weight
      t.decimal :reps
      t.decimal :target_reps
      t.text :notes
      t.references :exercise, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
