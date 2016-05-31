class GroupsController < ApplicationController
    before_action :authorise, :only => [:new]

  def new
      @group = Group.new
  end

  def create

    params[:group][:join_code] = SecureRandom.hex(10)
    @group_id = params[:group][:id]
    @group = Group.create group_params
    creator


      if @group.save
        redirect_to home_path
      else
        render :new
      end
  end

  def show
      @group = Group.find params[:id]
  end



    private
    def group_params
      params.require(:group).permit(:name, :join_code)
    end

    def creator
      member_ass = UsersGroup.new(user_id: @current_user.id, group_id: @group.id, member_type: 0)

      member_ass.save
    end

    def comment_params
       params.require(:user_group).permit(:user_id, :group_id, :member_type)
    end


    def authorise
      redirect_to home_path unless session[:user_id].present?
    end
end
