class Exercise < ActiveRecord::Base
  belongs_to :workout
  has_many :exercise_sets, -> { order 'sort_order ASC' }

  validates_presence_of :name, :workout, :sort_order
  validates_numericality_of :sort_order
  validate :validate_sort_order

  before_validation :ensure_sort_order_has_value

  def self.ordered_by_workout
    joins(:workout).order('workouts.workout_date DESC')
  end

  def self.most_recent_with_name!(name)
    ordered_by_workout.find_by_name!(name)
  end

  def self.names
    distinct.pluck(:name)
  end

  def self.suggest_names(pattern)
    select(:name).where("name LIKE '?%'", pattern || '').distinct.pluck(:name)
  end

  def validate_sort_order
    if sort_order.present? && workout_id.present? && Exercise.where(workout_id: workout_id, sort_order: sort_order).exists?
      errors.add(:sort_order, "must be unique for given workout_id")
    end
  end

  def ensure_sort_order_has_value
    if new_record? && self.sort_order.blank?
      self.sort_order ||= (Exercise.where(workout_id: workout_id).maximum(:sort_order) || 0) + 1
    end
  end

  def to_builder
    Jbuilder.new do |b|
      b.extract! self, :id, :name, :notes, :updated_at, :created_at
      b.exercise_sets(exercise_sets.map{|s| s.to_builder })
    end
  end
end
