require "utils/i18n"

class Admin::LabelsController < Admin::ApplicationController
  # GET /labels
  # GET /labels.json
  def index
    @labels = Label.page(params[:page])
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
    @label = Label.find(params[:id])
    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)
  end

  # GET /labels/new
  # GET /labels/new.json
  def new
    @label = Label.new
    @label.suid = Label.next_suid
    @label.dictionary = Dictionary.find(params[:dictionary_id])
    Language.all.each do |language|
      @label.label_descriptions.build(lang: language.code3)
    end
    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)
  end

  # GET /labels/1/edit
  def edit
    @label = Label.find(params[:id])
    authorize! :edit, @label

    params[:dictionary_id] = @label.dictionary.id
    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)
  end

  # POST /labels
  # POST /labels.json
  def create
    dictionary = Dictionary.find(params[:label][:dictionary_id])
    params[:label].delete(:dictionary_id)

    @label = Label.new(params[:label])
    authorize! :create, @label
    @label.dictionary=dictionary

    if @label.save
      redirect_to admin_dictionary_label_path(@label.dictionary, @label), notice: 'Successfully created admin/label.'
    else
      render action: 'new'
    end
  end

  # PUT /labels/1
  # PUT /labels/1.json
  def update
    @label = Label.find(params[:id])
    authorize! :update, @label

    @descriptions = Utils::I18n.sort_descriptions(@label.label_descriptions)

    params[:label].delete(:dictionary_id)
    if @label.update_attributes(params[:label])
      redirect_to admin_dictionary_label_path(@label.dictionary, @label), notice: 'Label was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /labels/1
  # DELETE /labels/1.json
  def destroy
    @label = Label.find(params[:id])
    authorize! :destroy, @label

    dictionary = @label.dictionary
    @label.destroy

    redirect_to admin_dictionary_url(dictionary), notice: 'Successfully destroyed admin/label.'
  end

  def existing_suids
     existing_labels = Label.suid_starts_with(params[:suid])
     render json: existing_labels.map{|lbl| lbl.suid }.to_json
   end

end
