require 'test_helper'

class Admin::DictionariesControllerTest < ActionController::TestCase
  setup do
    @admin_dictionary = admin_dictionaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_dictionaries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_dictionary" do
    assert_difference('Admin::Dictionary.count') do
      post :create, admin_dictionary: @admin_dictionary.attributes
    end

    assert_redirected_to admin_dictionary_path(assigns(:admin_dictionary))
  end

  test "should show admin_dictionary" do
    get :show, id: @admin_dictionary
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_dictionary
    assert_response :success
  end

  test "should update admin_dictionary" do
    put :update, id: @admin_dictionary, admin_dictionary: @admin_dictionary.attributes
    assert_redirected_to admin_dictionary_path(assigns(:admin_dictionary))
  end

  test "should destroy admin_dictionary" do
    assert_difference('Admin::Dictionary.count', -1) do
      delete :destroy, id: @admin_dictionary
    end

    assert_redirected_to admin_dictionaries_path
  end
end
