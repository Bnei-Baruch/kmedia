require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::LessondescPatternsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => LessondescPattern.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    LessondescPattern.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    LessondescPattern.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_lessondesc_pattern_url(assigns[:lessondesc_pattern]))
  end

  it "edit action should render edit template" do
    get :edit, :id => LessondescPattern.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    LessondescPattern.any_instance.stubs(:valid?).returns(false)
    put :update, :id => LessondescPattern.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    LessondescPattern.any_instance.stubs(:valid?).returns(true)
    put :update, :id => LessondescPattern.first
    response.should redirect_to(admin_lessondesc_pattern_url(assigns[:lessondesc_pattern]))
  end

  it "destroy action should destroy model and redirect to index action" do
    lessondesc_pattern = LessondescPattern.first
    delete :destroy, :id => lessondesc_pattern
    response.should redirect_to(admin_lessondesc_patterns_url)
    LessondescPattern.exists?(lessondesc_pattern.id).should be_false
  end
end
