class Admin::DictionariesController < Admin::ApplicationController
  # GET /admin/dictionaries
  # GET /admin/dictionaries.json
  def index
    @dictionaries = Dictionary.page(params[:page])
  end

  # GET /admin/dictionaries/1
  # GET /admin/dictionaries/1.json
  def show
    @dictionary = Dictionary.find(params[:id])
  end

  # GET /admin/dictionaries/new
  # GET /admin/dictionaries/new.json
  def new
    @dictionary = Dictionary.new
    Language.all.each do |language|
      @dictionary.dictionary_descriptions.build(lang: language.code3)
    end
  end

  # GET /admin/dictionaries/1/edit
  def edit
    @dictionary = Dictionary.find(params[:id])
  end

  # POST /admin/dictionaries
  # POST /admin/dictionaries.json
  def create
    @dictionary = Dictionary.new(params[:dictionary])
    authorize! :create, @dictionary

    if @dictionary.save
      redirect_to admin_dictionary_path(@dictionary), notice: 'Successfully created admin/dictionary.'
    else
      render :action => 'new'
    end
  end

  # PUT /admin/dictionaries/1
  # PUT /admin/dictionaries/1.json
  def update
    @dictionary = Dictionary.find(params[:id])
    authorize! :update, @dictionary

    if @admin_dictionary.update_attributes(params[:dictionary])
      redirect_to @dictionary, notice: 'Dictionary was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /admin/dictionaries/1
  # DELETE /admin/dictionaries/1.json
  def destroy
    @dictionary = Dictionary.find(params[:id])
    authorize! :destroy, @dictionary
    @dictionary.destroy
    redirect_to admin_dictionaries_url, notice: 'Successfully destroyed admin/dictionary.'
  end
end
