class SpaController < ApplicationController

  before_action :set_workout

  def index
  end

  def workout
    #@workout = Workout.includes(:cardios, exercises: [:exercise_sets]).find(params[:id])
  end

  def workout2
    #@workout = Workout.includes(:cardios, exercises: [:exercise_sets]).find(params[:id])
  end

  def workout3

  end

  private

  def set_workout
    id = params[:id]
    if id
      @workout = Workout.includes(:cardios, exercises: [:exercise_sets]).find(params[:id])
    else
      @workout = Workout.includes(:cardios, exercises: [:exercise_sets]).first
    end
  end
end
