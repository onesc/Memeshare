class UsersGroupsController < ApplicationController
 #  enum member_type: {
 #   creator: 0,
 #   moderator: 1,
 #   member: 2,
 #   god: 3
 # }

 def new
     @new_member = UsersGroup.new
 end

 def create
   @joincode = params["users_group"]["user_id"]
   @group_id = Group.find_by(join_code: @joincode).id
   if Group.find_by(join_code: @joincode) == nil
     redirect_to home_path
   else
    authorise_member
    redirect_to home_path
   end
 end

 def destroy
  member_ass = UsersGroup.find_by(user_id: @current_user.id, group_id: params["format"])
  member_ass.destroy
  redirect_to home_path
end




 private
  def find_group
    Group.find_by(join_code: @joincode).id
  end

  def join
    member_ass = UsersGroup.new(user_id: @current_user.id, group_id: @group_id, member_type: 2)
    member_ass.save
  end

  def authorise_member
    authorised = false
      UsersGroup.all.each do |ug|
          if ug.user_id == session[:user_id] && ug.group_id == @group_id
            authorised = true
          end
      end
    join unless authorised == true
  end

end