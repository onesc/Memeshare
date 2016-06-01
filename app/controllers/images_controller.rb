class ImagesController < ApplicationController
    before_action :authorise_member, :only => [:show]


  def new
    @image = Image.new
  end

  def create
      params[:image][:user_id] = @current_user.id


      if params[:group_id] == nil
        flash[:error] = "You must choose a group to submit to"
        redirect_to new_image_path
      else
        params[:image][:group_id] = params[:group_id][:group_id]
        @image = Image.create user_params
        redirect_to home_path
      end
  end

  def show

      @image = Image.find params[:id]
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


end
