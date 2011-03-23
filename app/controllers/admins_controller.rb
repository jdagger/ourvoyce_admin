class AdminsController < ApplicationController
  skip_before_filter :check_admin, :only => [:index, :login, :logout]
  skip_before_filter :require_user, :only => [:index, :login]

  def index
    @user_session = UserSession.new
  end

  def login
    @user_session = UserSession.new(:login => params[:login], :password => params[:password])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default users_url
    elsif Rails.application.routes.recognize_path(request.referrer)[:controller] == 'home'
      #This is a temporary conditional to handle the login-only home page
      flash[:notice] = "Unable to login user"
      redirect_to root_url
    else
      flash[:notice] = "Unable to login user"
      @new_user = User.new #needed for new
      render :action => :index
    end
  end

  def logout
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_back_or_default root_url
  end

end
