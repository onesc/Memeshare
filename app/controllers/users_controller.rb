class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
  #This wont save it to the database


  if User.find_by(email: params[:user][:email]) == nil
      @user = User.create user_params
      #If it is able to tbe saved, show all of the users
      #Otherwise just render the form
      if @user.save
        session[:user_id] = @user.id
        redirect_to home_path
      else
        render :new
      end
  else
    flash[:error] = "A user with that email already exists"
    redirect_to new_user_path
  end

  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def authorise
    redirect_to login_path unless session[:user_id].present? && @current_user.admin?
  end


end
