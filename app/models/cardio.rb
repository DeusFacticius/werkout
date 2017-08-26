class Cardio < ActiveRecord::Base
  belongs_to :workout

  validates :name, :duration, :resistance_level, :distance, presence: true
  validates :duration, :resistance_level, :distance, numericality: { greater_than_or_equal_to: 0 }
  validates :calories, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  def to_builder
    Jbuilder.new do |b|
      b.extract! self, :id, :name, :duration, :resistance_level, :distance, :calories, :updated_at, :created_at
    end
  end
end
