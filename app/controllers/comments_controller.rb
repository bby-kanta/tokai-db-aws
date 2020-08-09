class CommentsController < ApplicationController

  def create
    video = Video.find(params[:video_id])
    comment = video.comments.build(comment_params)
    comment.user_id = current_user.id
    if comment.save
      redirect_to video_path(video)
    else
      redirect_to root_path
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:content, :video_id,:user_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end

end
