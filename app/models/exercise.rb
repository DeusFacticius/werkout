class Exercise < ActiveRecord::Base
  belongs_to :workout
  has_many :exercise_sets, -> { order 'sort_order ASC' }

  validates_presence_of :name, :workout, :sort_order
  validates_numericality_of :sort_order
  validate :sort_order_unique_for_workout_id

  before_validation :ensure_sort_order_has_value

  def self.suggest_names(pattern)
    select(:name).where("name LIKE '?%'", pattern || '').distinct.pluck(:name)
  end

  def sort_order_unique_for_workout_id
    if sort_order.present? && workout_id.present? && Exercise.where(workout_id: workout_id, sort_order: sort_order).exists?
      errors.add(:sort_order, "must be unique for given workout_id")
    end
  end

  def ensure_sort_order_has_value
    self.sort_order ||= Exercise.where(workout_id: workout_id).maximum(:sort_order) + 1
  end

  def to_builder
    Jbuilder.new do |b|
      b.extract! self, :id, :name, :notes, :updated_at, :created_at
      b.exercise_sets(exercise_sets.map{|s| s.to_builder })
    end
  end
end
