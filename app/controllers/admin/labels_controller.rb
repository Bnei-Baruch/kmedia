class Admin::LabelsController < ApplicationController
  # GET /labels
  # GET /labels.json
  def index
    @labels = Label.page(params[:page])
  end

  # GET /labels/1
  # GET /labels/1.json
  def show
    @label = Label.find(params[:id])
  end

  # GET /labels/new
  # GET /labels/new.json
  def new
    @label = Label.new
    @label.suid = "Initial system name"
    Language.all.each do |language|
      @label.label_descriptions.build(lang: language.code3)
    end
  end

  # GET /labels/1/edit
  def edit
    @label = Label.find(params[:id])
  end

  # POST /labels
  # POST /labels.json
  def create
    #dictionary = Dictionary.find(params[:label][:dictionary_id])
    dictionary = Dictionary.find(params[:label][:dictionary_id])
    params[:label].delete(:dictionary_id)

    @label = Label.new(params[:label])
    @label.dictionary=dictionary

    authorize! :create, @label

    if @label.save
      redirect_to admin_label_path(@label), notice: 'Successfully created admin/label.'
    else
      render action: 'new'
    end
  end

  # PUT /labels/1
  # PUT /labels/1.json
  def update
    @label = Label.find(params[:id])
    authorize! :update, @label

    if @label.update_attributes(params[:label])
      redirect_to admin_label_path(@label), notice: 'Label was successfully updated.'
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
end
