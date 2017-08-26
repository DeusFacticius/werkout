class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.text :notes
      t.references :workout, index: true, foreign_key: true
      t.integer :sort_order, null: false, default: 0

      t.timestamps null: false
    end
  end
end
