class ImagesController < ApplicationController
    before_action :authorise_member, :only => [:show]


  def new
    @image = Image.new
  end

  def create
      params[:image][:user_id] = @current_user.id
      if params[:image][:group_id] == nil
        raise "hell"
        flash[:error] = "You must choose a group to submit to"
        redirect_to new_image_path
      else
        @image = Image.create user_params
        redirect_to Group.find_by(id: params[:image][:group_id])
      end
  end

  def show
      @comment = Comment.new
      @image = Image.find params[:id]
      @group = Group.find(@image.group_id)
  end

  def destroy
   @image = Image.find params[:format]
   authorise_admin

   redirect_to home_path
  end



  private
  def user_params
    params.require(:image).permit(:image, :caption, :user_id, :group_id)
  end


  def authorise
    redirect_to home_path unless session[:user_id].present?
  end

  def authorise_member
    @image = Image.find params[:id]
    authorised = false
      UsersGroup.all.each do |ug|
          if ug.user_id == session[:user_id] && ug.group_id == @image.group_id
            authorised = true
          end
      end
    unless authorised == true
      flash[:error] = "You are not authorised to view this image"
      redirect_to home_path
    end
  end

  def authorise_admin
    # if the usersgroup table lists has a member type of 0 or 2, they may delete the photo
      authorised = false
        UsersGroup.all.each do |ug|
              if ug.user_id == session[:user_id] && ug.group_id == @image.group_id
                    if ug.member_type == 0 || session[:user_id] == @image.user.id || ug.member_type == 1
                    authorised = true
                    @image.destroy
                    end
              end
        end
        unless authorised == true
          flash[:error] = "You are not authorised to delete this image"
        end
  end




end
