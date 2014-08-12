require 'minitest_helper'

describe UiController do
  before do
    @container = FactoryGirl.build_stubbed(:container_one)
  end

  # describe 'index' do
  #   it 'must get index' do
  #     get :index
  #     response.must_be :success?
  #     assert_not_nil assigns(:todos)
  #   end
  # end
  #
  # describe 'new/create' do
  #   it 'must get new' do
  #     get :new
  #     response.must_be :success?
  #   end
  #
  #   it 'must create user' do
  #     assert_difference('User.count') do
  #       post :create, user: {email: 'gshilin@gmail.com'}
  #     end
  #
  #     assert_redirected_to admin_user_path(assigns(:user))
  #   end
  # end

  describe 'show Container with its FileAssets' do
    it 'must show Container' do
      get :show, id: @container
      response.must_be :success?
      must_render_template :show
      assert_equal @container.id, assigns[:item].id
    end
  end

  describe 'routing' do
    it 'properly routes' do
      assert_routing "/ui", controller: "ui", action: "index"
      assert_routing "/ui/1", controller: "ui", action: "show", id: "1"

      # assert_routing({ path: "/projects", method: "post" }, controller: "projects", action: "create")
      # assert_routing "/projects/new", controller: "projects", action: "new"
      # assert_routing "/projects/1/edit", controller: "projects", action: "edit", id: "1"
      # assert_routing({ path: "/projects/1", method: "patch" }, controller: "projects", action: "update", id: "1")
      # assert_routing({ path: "/projects/1", method: "delete" }, controller: "projects", action: "destroy", id: "1")
    end
  end

end

