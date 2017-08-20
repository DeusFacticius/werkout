require 'test_helper'

class CardiosControllerTest < ActionController::TestCase
  setup do
    @cardio = cardios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cardios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cardio" do
    assert_difference('Cardio.count') do
      post :create, cardio: { calories: @cardio.calories, distance: @cardio.distance, duration: @cardio.duration, name: @cardio.name, notes: @cardio.notes, resistance_level: @cardio.resistance_level, workout_id: @cardio.workout_id }
    end

    assert_redirected_to cardio_path(assigns(:cardio))
  end

  test "should show cardio" do
    get :show, id: @cardio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cardio
    assert_response :success
  end

  test "should update cardio" do
    patch :update, id: @cardio, cardio: { calories: @cardio.calories, distance: @cardio.distance, duration: @cardio.duration, name: @cardio.name, notes: @cardio.notes, resistance_level: @cardio.resistance_level, workout_id: @cardio.workout_id }
    assert_redirected_to cardio_path(assigns(:cardio))
  end

  test "should destroy cardio" do
    assert_difference('Cardio.count', -1) do
      delete :destroy, id: @cardio
    end

    assert_redirected_to cardios_path
  end
end
