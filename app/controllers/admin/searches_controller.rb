class Admin::SearchesController < ApplicationController
  before_filter :authenticate_user!

  def index
    set_fields
    render(@results.error? ? :error : :index)
  end

  def create
    set_fields
    render(@results.error? ? :error : :index)
  end

  private
  def set_fields
    if params[:search]
      query = params[:search][:search].gsub(/-/, '_')
    else
      query = ''
    end
    
    @results = ThinkingSphinx.search(query, :star => true, :match_mode => :extended,
                                     :ignore_errors => true, :page => params[:page], :per_page => 40)
  end

end
