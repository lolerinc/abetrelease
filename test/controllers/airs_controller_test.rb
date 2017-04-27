require 'test_helper'

class AIRsControllerTest < ActionController::TestCase
  setup do
    @air = airs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:airs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create air" do
    assert_difference('AIR.count') do
      post :create, air: { analysis: @air.analysis, assignee1: @air.assignee1, assignee2: @air.assignee2, assignee3: @air.assignee3, assignee4: @air.assignee4, conclusion: @air.conclusion, document_id: @air.document_id, meetingDate: @air.meetingDate, meetingName: @air.meetingName, name: @air.name, taken: @air.taken }
    end

    assert_redirected_to air_path(assigns(:air))
  end

  test "should show air" do
    get :show, id: @air
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @air
    assert_response :success
  end

  test "should update air" do
    patch :update, id: @air, air: { analysis: @air.analysis, assignee1: @air.assignee1, assignee2: @air.assignee2, assignee3: @air.assignee3, assignee4: @air.assignee4, conclusion: @air.conclusion, document_id: @air.document_id, meetingDate: @air.meetingDate, meetingName: @air.meetingName, name: @air.name, taken: @air.taken }
    assert_redirected_to air_path(assigns(:air))
  end

  test "should destroy air" do
    assert_difference('AIR.count', -1) do
      delete :destroy, id: @air
    end

    assert_redirected_to airs_path
  end
end
