class Workout < ActiveRecord::Base
  has_many :exercises,  -> { order 'sort_order ASC' }, dependent: :destroy
  has_many :cardios, dependent: :destroy

  validates_presence_of :workout_date
  validates_associated :exercises

  def to_builder
    Jbuilder.new do |b|
      b.extract! self, :id, :workout_date, :time_started, :time_ended, :split_name, :notes, :updated_at, :created_at
      b.exercises do
        b.array!(exercises.map{|e| e.to_builder })
      end
      #b.exercises(exercises.map{|e| e.to_builder })
      b.cardios(cardios.map{|c| c.to_builder })
    end
  end

  def previous_workout
    @previous_workout ||= Workout.where('workout_date < ?', self.workout_date).order(:workout_date, :desc).first
  end

  def next_workout
    @next_workout ||= Workout.where('workout_date > ?', self.workout_date).order(:workout_date).first
  end
end
