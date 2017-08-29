class ExerciseSet < ActiveRecord::Base
  belongs_to :exercise

  validates_presence_of :exercise, :reps, :sort_order
  validates_numericality_of :reps, :sort_order
  validates_numericality_of :weight, :target_reps, allow_nil: true

  validate :validate_sort_order

  before_validation :ensure_sort_order_has_value

  def validate_sort_order
    if sort_order.present? && exercise_id.present? && ExerciseSet.where(exercise_id: exercise_id, sort_order: sort_order).exists?
      errors.add(:sort_order, "must be unique for given exercise_id")
    end
  end

  def ensure_sort_order_has_value
    #self.sort_order ||= ExerciseSet.where(exercise_id: exercise_id).maximum(:sort_order) + 1
    if new_record? && sort_order.blank?
      self.sort_order ||= (ExerciseSet.where(exercise_id: self.exercise_id).maximum(:sort_order) || 0) + 1
    end
  end

  def to_builder
    Jbuilder.new do |b|
      b.extract! self, :id, :reps, :target_reps, :weight, :notes, :sort_order, :updated_at, :created_at
    end
  end

end
