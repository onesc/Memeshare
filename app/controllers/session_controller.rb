class SessionController < ApplicationController
  before_action :authenticate_user, :only => [:new]
  def new

  end

  def create
    #find the user using params[:email]
    user = User.find_by :email => params[:email]

    # if user with the email provided exists, and the pasword provided matches the password_digest, once encrypted, run the following info
    if user.present? && user.authenticate(params[:password])
      flash[:success] = "We found you"
      session[:user_id] = user.id
      redirect_to login_path
    else
      flash[:error] = "Invalid email or password"
      session[:user_id] = nil
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to home_path
  end

  private
    def authenticate_user
      redirect_to home_path if @current_user.present?
    end
end
