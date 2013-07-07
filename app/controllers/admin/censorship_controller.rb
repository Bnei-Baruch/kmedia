class Admin::CensorshipController < Admin::ApplicationController

  def index
    @lessons = Lesson.for_censorship.page(params[:page])
  end

  def clear
    lesson = Lesson.find(params[:id])
    lesson.update_attributes({
                                 for_censorship: false,
                                 opened_by_censor: true,
                                 closed_by_censor: false,
                                 censor_id: current_user.id
                             })
    @lessons = Lesson.for_censorship.page(params[:page])
    render :index, notice: 'Opened'
  end

  def disable
    lesson = Lesson.find(params[:id])
    lesson.for_censorship = false,
    lesson.opened_by_censor = false,
    lesson.closed_by_censor = true,
    lesson.censor_id = current_user.id
    lesson.catalogs = [Catalog::CLOSED_BY_CENSORSHIP]
    lesson.virtual_lesson = nil
    lesson.save

    @lessons = Lesson.for_censorship.page(params[:page])
    render :index, notice: 'Disabled forever'
  end
end