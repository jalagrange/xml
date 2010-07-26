require 'test_helper'

class ProcessesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:processes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create process" do
    assert_difference('Process.count') do
      post :create, :process => { }
    end

    assert_redirected_to process_path(assigns(:process))
  end

  test "should show process" do
    get :show, :id => processes(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => processes(:one).to_param
    assert_response :success
  end

  test "should update process" do
    put :update, :id => processes(:one).to_param, :process => { }
    assert_redirected_to process_path(assigns(:process))
  end

  test "should destroy process" do
    assert_difference('Process.count', -1) do
      delete :destroy, :id => processes(:one).to_param
    end

    assert_redirected_to processes_path
  end
end
