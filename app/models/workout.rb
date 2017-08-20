class Workout < ActiveRecord::Base
  has_many :exercises, dependent: :destroy
  has_many :cardios, dependent: :destroy

  validates_presence_of :workout_date
end
