require File.dirname(__FILE__) + '/../spec_helper'

describe SearchesController do
  fixtures :all
  render_views

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Search.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Search.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(search_url(assigns[:search]))
  end

  it "show action should render show template" do
    get :show, :id => Search.first
    response.should render_template(:show)
  end
end
