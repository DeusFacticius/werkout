require 'test_helper'

class ExercisesControllerTest < ActionController::TestCase
  setup do
    @exercise = exercises(:cable_shoulder_press)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:exercises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create exercise" do
    assert_difference('Exercise.count') do
      post :create, exercise: { name: @exercise.name, notes: @exercise.notes, workout_id: @exercise.workout_id }
    end

    assert_redirected_to exercise_path(assigns(:exercise))
  end

  test "should show exercise" do
    get :show, id: @exercise
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @exercise
    assert_response :success
  end

  test "should update exercise" do
    patch :update, id: @exercise, exercise: { name: @exercise.name, notes: @exercise.notes, workout_id: @exercise.workout_id }
    assert_redirected_to exercise_path(assigns(:exercise))
  end

  test "should destroy exercise" do
    assert_difference('Exercise.count', -1) do
      delete :destroy, id: @exercise
    end

    assert_redirected_to exercises_path
  end

  test "should get most recent exercise with name" do
    get :most_recent_with_name, parameters: {name: @exercise.name}
    assert_response :success
  end

  test "should get a list of distinct names" do
    get :names
    assert_response :success
    assert_not_nil assigns['names']
    assert_includes assigns['names'], 'Leg Curls'
    assert_includes assigns['names'], 'Lat Pulldown'
    assert_includes assigns['names'], 'Chest Press'
    assert_equal assigns['names'].uniq, assigns['names']
  end
end
