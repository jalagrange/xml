require 'test_helper'

class ProyectsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proyects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proyect" do
    assert_difference('Proyect.count') do
      post :create, :proyect => { }
    end

    assert_redirected_to proyect_path(assigns(:proyect))
  end

  test "should show proyect" do
    get :show, :id => proyects(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => proyects(:one).to_param
    assert_response :success
  end

  test "should update proyect" do
    put :update, :id => proyects(:one).to_param, :proyect => { }
    assert_redirected_to proyect_path(assigns(:proyect))
  end

  test "should destroy proyect" do
    assert_difference('Proyect.count', -1) do
      delete :destroy, :id => proyects(:one).to_param
    end

    assert_redirected_to proyects_path
  end
end
