class Cardio < ActiveRecord::Base
  belongs_to :workout

  validates :name, :duration, :resistance_level, :distance, presence: true
  validates :duration, :resistance_level, :distance, numericality: { greater_than_or_equal_to: 0 }
  validates :calories, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
end
