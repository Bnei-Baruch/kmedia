class Admin::UsersController < Admin::ApplicationController
  before_filter :get_user, :only => [:index, :new, :edit, :become]
  before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create, :become]
  load_and_authorize_resource :only => [:show, :new, :destroy, :edit, :update]

  # GET /users
  # GET /users.xml
  # GET /users.json                                       HTML and AJAX
  #-----------------------------------------------------------------------
  def index
    @users = User.accessible_by(current_ability, :index).order(:first_name,:last_name).page(params[:page]).includes([:department, :roles])
  end

  # GET /users/new
  # GET /users/new.xml
  # GET /users/new.json                                    HTML AND AJAX
  #-------------------------------------------------------------------
  def new
  end

  # GET /users/1
  # GET /users/1.xml
  # GET /users/1.json                                     HTML AND AJAX
  #-------------------------------------------------------------------
  def show
  end

  # GET /users/1/edit
  # GET /users/1/edit.xml
  # GET /users/1/edit.json                                HTML AND AJAX
  #-------------------------------------------------------------------
  def edit
    @user.generate_token
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  # DELETE /users/1.json                                  HTML AND AJAX
  #-------------------------------------------------------------------
  def destroy
    @user.destroy

    redirect_to admin_users_url, :notice => "Successfully destroyed admin/user."
  end

  # POST /users
  # POST /users.xml
  # POST /users.json                                      HTML AND AJAX
  #-----------------------------------------------------------------
  def create
    @user = User.new
    if params[:user][:password].blank? || params[:user][:password] != params[:user][:password_confirmation]
      @user.errors[:password] << "The password you entered is incorrect"
      render :action => 'new'
    else
      permitted = can? :update, :users
      if @user.update_attributes(params[:user], :without_protection => permitted)
        redirect_to admin_users_url, :notice => "Successfully created user."
      else
        render :action => 'new'
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  # PUT /users/1.json                                            HTML AND AJAX
  #----------------------------------------------------------------------------
  def update
    if params[:user][:password].blank?
      [:password, :password_confirmation, :current_password].collect { |p| params[:user].delete(p) }
    else
      @user.errors[:password] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password]) || current_user.role?(:super_admin)
      @user.errors[:password] << "The password differs from confirmation" unless params[:user][:password] == params[:user][:password_confirmation]
      params[:user].delete(:current_password)
    end

    if params[:user][:reset_password_token] != @user.reset_password_token
      @user.errors[:first_name] << "Sorry, but you don't have permission to change users' data"
      render :action => 'edit'
      return
    end

    if @user.errors[:password].empty? && @user.errors[:current_password].empty?
      permitted = can? :update, :users
      if @user.update_attributes(params[:user], :without_protection => permitted)
        redirect_to admin_user_path(@user), :notice => "Your account has been updated"
      else
        render :action => 'edit'
      end
    else
      render :action => 'edit'
    end
  end

  def become
    return unless current_user.role?(:super_admin)
    sign_in(:user, User.find(params[:id]))
    redirect_to root_url # or user_root_url
  end

  private
  # Get roles accessible by the current user
  #----------------------------------------------------
  def accessible_roles
    @accessible_roles = Role.accessible_by(current_ability, :read).all
    a = 1
  end

  # Make the current user object available to views
  #----------------------------------------
  def get_user
    @current_user = current_user
  end
end
