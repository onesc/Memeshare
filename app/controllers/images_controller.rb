class ImagesController < ApplicationController
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


  private
  def user_params
    params.require(:image).permit(:image, :caption, :user_id, :group_id)
  end


end
