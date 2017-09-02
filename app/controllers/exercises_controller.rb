class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[show edit update destroy]

  # Note: actions :index, :new, :create may be nested under /workouts/:workout_id/exercises

  # GET /exercises
  # GET /exercises.json
  # GET /workout/:workout_id/exercises
  # GET /workout/:workout_id/exercises.json
  def index
    if params[:workout_id].present?
      @workout = Workout.find(params[:workout_id])
      @exercises = @workout.exercises
    else
      @exercises = Exercise.all
    end
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show; end

  # GET /exercises/new
  # GET /workouts/:workout_id/exercises/new
  def new
    if params[:workout_id].present?
      @workout = Workout.find(params[:workout_id])
      @exercise = @workout.exercises.build
    else
      @exercise = Exercise.new
    end
  end

  # GET /exercises/1/edit
  def edit; end

  # POST /exercises
  # POST /exercises.json
  # POST /workout/:workout_id/exercises
  # POST /workout/:workout_id/exercises.json
  def create
    if params[:workout_id].present?
      @workout = Workout.find(params[:workout_id])
      @exercise = @workout.exercises.build(exercise_params.permit(:name, :notes))
    else
      @exercise = Exercise.new(exercise_params)
    end

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to @exercise, notice: 'Exercise was successfully created.' }
        format.json { render :show, status: :created, location: @exercise }
      else
        format.html { render :new }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exercises/1
  # PATCH/PUT /exercises/1.json
  def update
    respond_to do |format|
      if @exercise.update(exercise_params)
        format.html { redirect_to @exercise, notice: 'Exercise was successfully updated.' }
        format.json { render :show, status: :ok, location: @exercise }
      else
        format.html { render :edit }
        format.json { render json: @exercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise.destroy
    respond_to do |format|
      format.html { redirect_to exercises_url, notice: 'Exercise was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def names
    @names = Exercise.names
    render json: @names
  end

  def most_recent_with_name
    name = params[:name]
    exclude = params[:exclude]
    @exercise = Exercise.includes(:exercise_sets, :workout).where.not(id: exclude).most_recent_with_name!(name)
    @include_workout = true
    render :show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exercise
    src = Exercise
    if params[:full]
      src = Exercise.includes(:exercise_sets, :workout)
    end
    @exercise = src.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def exercise_params
    params.require(:exercise).permit(:name, :notes, :workout_id)
  end

end
