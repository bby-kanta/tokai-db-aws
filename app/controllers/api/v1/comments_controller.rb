class Api::V1::CommentsController < ApiController

  def index
    render json: Comment.includes(:user)
  end
    
  def create
    current_user.comments.create!(comments_params)
    head :created
  end

  def destroy
    Comment.find(params[:id]).destroy!
    head :ok
  end


  private

  def comments_params
    params.require(:comment).permit(:video_id,:user_id,:content)
  end

end