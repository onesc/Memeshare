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
            @group_members << User.find_by(id: ug.user_id)
          end
      end

      authorise_member
  end

  def admin

    @group = Group.find params[:format]
    authorise_admin
    @group_members = []
    UsersGroup.all.each do |ug|
        if ug.group_id == @group.id
          case ug.member_type
          when 0
            member_value = "Creator"
          when 1
            member_value = "Moderator"
          when 2
            member_value = "Member"
          end

          @group_members << [User.find_by(id: ug.user_id).name, member_value, ug.user_id]
        end
    end
  end

  def toggle_joinable
  toggle(params[:group_id])
  redirect_to admin_page_path(@group)
  end

  def member_change

      change_member_value(params[:user_id], params[:group_id], params[:change_value])
      redirect_to admin_page_path(Group.find(params[:group_id]))
  end





    private
    def group_params
      params.require(:group).permit(:name, :join_code)
    end

    def toggle (group_id)
      @group = Group.find(group_id)
      if @group.joinable == true
        @group.update_attribute(:joinable, false)
      else
        @group.update_attribute(:joinable, true)
      end
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



    def authorise_admin
      authorised = false
        UsersGroup.all.each do |ug|
            if ug.user_id == session[:user_id] && ug.group_id == @group.id && ug.member_type == 0
              authorised = true
            end
        end
      unless authorised == true
        flash[:error] = "You do not have Admin privileges for this group"
        redirect_to home_path
      end
    end



    def change_member_value(user_id, group_id, change_value)
      @ug = UsersGroup.find_by(user_id: user_id, group_id: group_id)
        case change_value
        when "0", "1", "2"
          @ug.update_attribute(:member_type, change_value.to_i)
        when "3"
          @ug.destroy
        end
    end

end
