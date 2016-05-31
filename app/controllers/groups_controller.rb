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
      @images = Image.where(group_id: @group.id)
  
      @group_members = []
      UsersGroup.all.each do |ug|
          if ug.group_id == @group.id
            @group_members << User.find_by(id: ug.user_id).name
          end
      end

      authorise_member
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

    def authorise_member
      authorised = false
        UsersGroup.all.each do |ug|
            if ug.user_id == session[:user_id] && ug.group_id == @group.id
              authorised = true
            end
        end
      redirect_to home_path unless authorised == true
    end

end
