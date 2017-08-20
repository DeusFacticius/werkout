class CreateCardios < ActiveRecord::Migration
  def change
    create_table :cardios do |t|
      t.string :name, null: false
      t.integer :duration, null: false
      t.integer :resistance_level, null: false, default: 1
      t.text :notes
      t.decimal :distance, null: false, default: 0
      t.decimal :calories
      t.references :workout, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
