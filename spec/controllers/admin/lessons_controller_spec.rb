require File.dirname(__FILE__) + '/../spec_helper'

describe Admin::LessonsController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "show action should render show template" do
    get :show, :id => Lesson.first
    response.should render_template(:show)
  end

  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end

  it "create action should render new template when model is invalid" do
    Lesson.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end

  it "create action should redirect when model is valid" do
    Lesson.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(admin_lesson_url(assigns[:admin_lesson]))
  end

  it "edit action should render edit template" do
    get :edit, :id => Lesson.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Lesson.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Lesson.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Lesson.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Lesson.first
    response.should redirect_to(admin_lesson_url(assigns[:admin_lesson]))
  end

  it "destroy action should destroy model and redirect to index action" do
    admin_lesson = Lesson.first
    delete :destroy, :id => admin_lesson
    response.should redirect_to(admin_lessons_url)
    Lesson.exists?(admin_lesson.id).should be_false
  end
end
