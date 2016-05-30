class GroupsController < ApplicationController
  def new
      @group = Group.new
  end

  def create

    params[:group][:join_code] = SecureRandom.hex(10)

    @group = Group.create group_params


    if @group.save
      redirect_to home_path
    else
      render :new
    end
    end



    private
    def group_params

      params.require(:group).permit(:name, :join_code)
    end

    def authorise
      redirect_to login_path unless session[:user_id].present? && @current_user.admin?
    end
end
