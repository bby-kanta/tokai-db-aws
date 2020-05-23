class VideosController < ApplicationController

  def index
    @videos = Video.all.order(created_at:'desc')
    # @tags = @video.tags
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      redirect_to videos_path
    else
      render 'new'
    end
  end

  private
    def video_params
      params.require(:video).permit(:url,:title,:kind_of,:rate,:description,:highlight,:category,:quotes,:mvp,:editor,:updated_on)
    end

end
