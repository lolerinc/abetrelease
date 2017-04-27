require 'test_helper'

class PIEsControllerTest < ActionController::TestCase
  setup do
    @pie = pies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pie" do
    assert_difference('PIE.count') do
      post :create, pie: { abet_outcome: @pie.abet_outcome, calculation: @pie.calculation, description: @pie.description, document_id: @pie.document_id, name: @pie.name, rpercent: @pie.rpercent, rscore: @pie.rscore, tpercent: @pie.tpercent, tscore: @pie.tscore }
    end

    assert_redirected_to pie_path(assigns(:pie))
  end

  test "should show pie" do
    get :show, id: @pie
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pie
    assert_response :success
  end

  test "should update pie" do
    patch :update, id: @pie, pie: { abet_outcome: @pie.abet_outcome, calculation: @pie.calculation, description: @pie.description, document_id: @pie.document_id, name: @pie.name, rpercent: @pie.rpercent, rscore: @pie.rscore, tpercent: @pie.tpercent, tscore: @pie.tscore }
    assert_redirected_to pie_path(assigns(:pie))
  end

  test "should destroy pie" do
    assert_difference('PIE.count', -1) do
      delete :destroy, id: @pie
    end

    assert_redirected_to pies_path
  end
end
