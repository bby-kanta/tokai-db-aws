class Api::V1::TagVideosController < ApiController

  def index
    render json: TagVideo.select(:id, :tag_id, :video_id)
  end
    
  def create
    TagVideo.create!(tag_params)
  end

  def destroy
    TagVideo.find(params[:id]).destroy!
    head :ok
  end


  private

  def tag_params
    params.require(:tag_video).permit(:video_id,:tag_id)
  end

end