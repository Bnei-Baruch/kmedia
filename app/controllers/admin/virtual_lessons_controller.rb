class Admin::VirtualLessonsController < Admin::ApplicationController
  load_resource :only => [:show, :new, :destroy, :edit, :update]
  authorize_resource
  respond_to :html, :json

  def index
    @virtual_lessons = VirtualLesson.includes(:containers).order('film_date DESC').page(params[:page])
  end

  def new
  end

  def show
  end

  def edit
  end

  def destroy
    @virtual_lesson.destroy

    redirect_to admin_virtual_lessons_url, notice: 'Successfully destroyed virtual lesson.'
  end

  def create
    raise 'Not implemented yet'
  end

  def update
    permitted       = can? :update, :virtual_lesson
    @virtual_lesson = VirtualLesson.find params[:id]

    respond_to do |format|
      if @virtual_lesson.update_attributes(params[:virtual_lesson], :without_protection => permitted) &&
          @virtual_lesson.update_attribute(:user_id, current_user.id)
        format.html { redirect_to admin_virtual_lessons_path(@virtual_lesson), :notice => "Virtual lesson was successfully updated" }
        format.json { respond_with_bip(@virtual_lesson) }
      else
        format.html { render action: :edit }
        format.json { respond_with_bip(@virtual_lesson) }
      end
    end
  end

  def reorder
    permitted = can? :update, :virtual_lesson
    render text: 'You don\'t have permission to do it' and return unless permitted

    @virtual_lesson = VirtualLesson.find params[:id]
    params[:position].each_with_index do |id, index|
      Container.find(id).update_attribute(:position, index + 1)
    end

    render text: 'OK'
  end

  def combine
    permitted = can? :update, :virtual_lesson
    render text: 'You don\'t have permission to do it' and return unless permitted

    notice = VirtualLesson.combine(params[:vls])

    redirect_to admin_virtual_lessons_path, notice: notice
  end
end
