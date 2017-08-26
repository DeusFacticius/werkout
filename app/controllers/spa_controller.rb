class SpaController < ApplicationController
  def index
  end

  def workout
    @workout = Workout.includes(:cardios, exercises: [:exercise_sets]).find(params[:id])
  end

  def workout2
    @workout = Workout.includes(:cardios, exercises: [:exercise_sets]).find(params[:id])
  end
end
