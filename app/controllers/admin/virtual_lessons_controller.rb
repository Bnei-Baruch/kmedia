class Admin::VirtualLessonsController < Admin::ApplicationController
  load_resource :only => [:show, :new, :destroy, :edit, :update]
  authorize_resource

  # GET /virtual_lesson
  # GET /virtual_lesson.xml
  # GET /virtual_lesson.json                                       HTML and AJAX
  #-----------------------------------------------------------------------
  def index
    @virtual_lessons = VirtualLesson.order(sort_order).page(params[:page])
  end

  # GET /virtual_lesson/new
  # GET /virtual_lesson/new.xml
  # GET /virtual_lesson/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
  end

  # GET /virtual_lesson/1
  # GET /virtual_lesson/1.xml
  # GET /virtual_lesson/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
  end

  # GET /virtual_lesson/1/edit
  # GET /virtual_lesson/1/edit.xml
  # GET /virtual_lesson/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
  end

  # DELETE /virtual_lesson/1
  # DELETE /virtual_lesson/1.xml
  # DELETE /virtual_lesson/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
    @virtual_lesson.destroy

    redirect_to admin_virtual_lessons_url, :notice => "Successfully destroyed virtual lesson."
  end

  # POST /virtual_lesson
  # POST /virtual_lesson.xml
  # POST /virtual_lesson.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    @virtual_lesson = VirtualLesson.new
    permitted = can? :update, :virtual_lesson
    if @user.update_attributes(params[:user], :without_protection => permitted)
      redirect_to admin_users_url, :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  # PUT /virtual_lesson/1
  # PUT /virtual_lesson/1.xml
  # PUT /virtual_lesson/1.json                                            HTML AND AJAX
  #----------------------------------------------------------------------------
  def update
    permitted = can? :update, :users
    if @user.update_attributes(params[:user], :without_protection => permitted)
      redirect_to admin_user_path(@user), :notice => "Your account has been updated"
    else
      render :action => 'edit'
    end
  end

end
