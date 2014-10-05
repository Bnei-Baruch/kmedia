class Admin::CensorshipController < Admin::ApplicationController

  def index
    @lessons = Container.for_censorship.page(params[:page])
  end

  def show
    @container    = Container.for_censorship.find(params[:id])
    @censor_email = @container.censor_id ? User.where(id: @container.censor_id).pluck(:email)[0] : nil
  end

  def clear
    container = Container.find(params[:id])
    container.update_attributes({
                                 for_censorship:   false,
                                 opened_by_censor: true,
                                 closed_by_censor: false,
                                 censor_id:        current_user.id
                             })
    @containers = Container.for_censorship.page(params[:page])
    render :index, notice: 'Opened'
  end

  def disable
    container = Container.find(params[:id])
    container.update_attributes({
                                 for_censorship:   false,
                                 opened_by_censor: false,
                                 closed_by_censor: true,
                                 censor_id:        current_user.id,
                                 catalogs:         [Catalog::CLOSED_BY_CENSORSHIP],
                                 virtual_lesson:   nil
                             })

    @ocntainers = Container.for_censorship.page(params[:page])
    render :index, notice: 'Disabled forever'
  end
end
