class CommentsController < ApplicationController

def create
  raise "hell"
end

def create
  params[:comment][:user_id] = params[:user_id]
  params[:comment][:image_id] = params[:image_id]

      @comment = Comment.create comment_params
      redirect_to Image.find_by(id: params[:image_id])

end

def destroy
  @comment = Comment.find(params[:comment_id])
  @comment.destroy
  redirect_to Image.find(params[:image])
end


private
def comment_params
  params.require(:comment).permit(:content, :user_id, :image_id)
end

end
