class Admin::SearchesController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!

  def index
    set_fields
    a = 1
  end

  def create
    set_fields
    render :index
  end

  private
  def set_fields
    @search = Search.new(params[:search])
    @results = ThinkingSphinx.search(params[:search][:search], :star => true, :match_mode => :extended, :page => params[:page], :per_page => 40)
  end

end
