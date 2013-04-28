class Admin::VirtualLessonsController < Admin::ApplicationController
  load_resource :only => [:show, :new, :destroy, :edit, :update]
  authorize_resource
  respond_to :html, :json

  def index
    @virtual_lessons = VirtualLesson.includes(:lessons, lessons: :file_assets).order('film_date DESC, position ASC').page(params[:page])
  end

  def new
  end

  def show
  end

  def edit
  end

  def destroy
    @virtual_lesson.destroy

    redirect_to admin_virtual_lessons_url, :notice => "Successfully destroyed virtual lesson."
  end

  def create
    raise 'Not implemented yet'
  end

  def update
    permitted = can? :update, :virtual_lesson
    @virtual_lesson = VirtualLesson.find params[:id]

    respond_to do |format|
      if @virtual_lesson.update_attributes(params[:virtual_lesson], :without_protection => permitted)
        format.html { redirect_to admin_virtual_lessons_path(@virtual_lesson), :notice => "Virtual lesson was successfully updated" }
        format.json { respond_with_bip(@virtual_lesson) }
      else
        format.html { render action: :edit }
        format.json { respond_with_bip(@virtual_lesson) }
      end
    end
  end

  def combine
    permitted = can? :update, :virtual_lesson

    # Move containers to the target VL and remove empty VLs
    vls = params[:vls].split(',').map {|vl| VirtualLesson.find vl }
    target = vls.shift
    vls.each do |vl|
      vl.lessons.each do |lesson|
        target.lessons << lesson
      end
      vl.destroy
    end

    # TODO: Renumber containers in the target VL

    # Renumber VLs
    VirtualLesson.vls_from_date(target.film_date).each_with_index do |vl, index|
      vl.update_attribute :position, index
    end

    redirect_to admin_virtual_lessons_path, notice: "Container(s) #{vls.map(&:id).join(',')} successfully moved to #{target.id}"
  end
end
