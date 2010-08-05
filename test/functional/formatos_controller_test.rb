require 'test_helper'

class FormatosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:formatos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create formato" do
    assert_difference('Formato.count') do
      post :create, :formato => { }
    end

    assert_redirected_to formato_path(assigns(:formato))
  end

  test "should show formato" do
    get :show, :id => formatos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => formatos(:one).to_param
    assert_response :success
  end

  test "should update formato" do
    put :update, :id => formatos(:one).to_param, :formato => { }
    assert_redirected_to formato_path(assigns(:formato))
  end

  test "should destroy formato" do
    assert_difference('Formato.count', -1) do
      delete :destroy, :id => formatos(:one).to_param
    end

    assert_redirected_to formatos_path
  end
end
