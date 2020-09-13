class Api::V1::MusicVideosController < ApiController

  def index
    render json: MusicVideo.select(:id, :music_id, :video_id)
  end

  def show
    render json:MusicVideo.where(video_id: params[:id]).select(:id, :music_id, :video_id)
  end

  def create
    MusicVideo.create!(music_params)
  end

  def destroy
    MusicVideo.find(params[:id]).destroy!
    head :ok
  end


  private

  def music_params
    params.require(:music_video).permit(:video_id,:music_id)
  end

end