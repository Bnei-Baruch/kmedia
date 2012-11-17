require "utils/i18n"

class Admin::LabelsController < Admin::ApplicationController
  load_and_authorize_resource

  # GET /labels
  # GET /labels.json
  def index
    @labels = @labels.page(params[:page])
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)
  end

  # GET /labels/new
  # GET /labels/new.json
  def new
    @label.fill_defaults(params[:dictionary_id])
    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)
  end

  # GET /labels/1/edit
  def edit
    params[:dictionary_id] = @label.dictionary.id
    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)
  end

  # POST /labels
  # POST /labels.json
  def create
    if @label.save
      redirect_to admin_dictionary_label_path(@label.dictionary, @label), notice: 'Successfully created admin/label.'
    else
      render :new
    end
  end

  # PUT /labels/1
  # PUT /labels/1.json
  def update
    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)

    if @label.update_attributes(params[:label])
      redirect_to admin_dictionary_label_path(@label.dictionary, @label), notice: 'Label was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    dictionary = @label.dictionary
    @label.destroy

    redirect_to admin_dictionary_url(dictionary), notice: 'Successfully destroyed admin/label.'
  end

  def existing_suids
     render json: Label.suid_starts_with(params[:suid]).map{|lbl| lbl.suid }.to_json
  end

  def assignable
    @labels = Label
    .select("labels.id, text")
    .order("text asc")
    .accessible_by(current_ability)

    if params[:q]
      @labels = @labels.joins(:label_descriptions).where("lang='ENG' and text like ?", "%#{params[:q]}%")
    else
      @labels = @labels.page(params[:page])
    end

    respond_to do |format|
      format.html
      format.json { render :json => @labels.map { |lbl| { :id => lbl.id, :name => lbl.text } } }
    end
  end

end
