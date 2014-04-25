class Admin::CensorshipController < Admin::ApplicationController

  def index
    @lessons = Lesson.for_censorship.page(params[:page])
  end

  def show
    @lesson       = Lesson.for_censorship.find(params[:id])
    @censor_email = @lesson.censor_id ? User.where(id: @lesson.censor_id).pluck(:email)[0] : nil
  end

  def clear
    lesson = Lesson.find(params[:id])
    lesson.update_attributes({
                                 for_censorship:   false,
                                 opened_by_censor: true,
                                 closed_by_censor: false,
                                 censor_id:        current_user.id
                             })
    @lessons = Lesson.for_censorship.page(params[:page])
    render :index, notice: 'Opened'
  end

  def disable
    lesson = Lesson.find(params[:id])
    lesson.update_attributes({
                                 for_censorship:   false,
                                 opened_by_censor: false,
                                 closed_by_censor: true,
                                 censor_id:        current_user.id,
                                 catalogs:         [Catalog::CLOSED_BY_CENSORSHIP],
                                 virtual_lesson:   nil
                             })

    @lessons = Lesson.for_censorship.page(params[:page])
    render :index, notice: 'Disabled forever'
  end
end
