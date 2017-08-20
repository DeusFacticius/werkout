class Exercise < ActiveRecord::Base
  belongs_to :workout
  has_many :exercise_sets

  validates_presence_of :name, :workout

  def self.suggest_names(pattern)
    select(:name).where("name LIKE '?%'", pattern || '').distinct.pluck(:name)
  end
end
