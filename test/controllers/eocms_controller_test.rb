require 'test_helper'

class EOCMsControllerTest < ActionController::TestCase
  setup do
    @eocm = eocms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:eocms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create eocm" do
    assert_difference('EOCM.count') do
      post :create, eocm: { comment_additional: @eocm.comment_additional, comment_changes: @eocm.comment_changes, comment_failed: @eocm.comment_failed, comment_implemented: @eocm.comment_implemented, comment_outcomes: @eocm.comment_outcomes, comment_rec: @eocm.comment_rec, comment_results: @eocm.comment_results, comment_worked: @eocm.comment_worked, document_id: @eocm.document_id, evaluation: @eocm.evaluation }
    end

    assert_redirected_to eocm_path(assigns(:eocm))
  end

  test "should show eocm" do
    get :show, id: @eocm
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @eocm
    assert_response :success
  end

  test "should update eocm" do
    patch :update, id: @eocm, eocm: { comment_additional: @eocm.comment_additional, comment_changes: @eocm.comment_changes, comment_failed: @eocm.comment_failed, comment_implemented: @eocm.comment_implemented, comment_outcomes: @eocm.comment_outcomes, comment_rec: @eocm.comment_rec, comment_results: @eocm.comment_results, comment_worked: @eocm.comment_worked, document_id: @eocm.document_id, evaluation: @eocm.evaluation }
    assert_redirected_to eocm_path(assigns(:eocm))
  end

  test "should destroy eocm" do
    assert_difference('EOCM.count', -1) do
      delete :destroy, id: @eocm
    end

    assert_redirected_to eocms_path
  end
end
