class VideosController < ApplicationController

  def index
    @videos  = Video.all.order(updated_on:'desc')
    @main    = @videos.where(kind_of: 0)
    @sub     = @videos.where(kind_of: 1)
    @private = @videos.where(kind_of:2)
    @other   = @videos.where(kind_of:3)
  end

  def search
    @search = Video.ransack(params[:q])
    @videos = @search.result
    @main    = @videos.where(kind_of: 0)
    @sub     = @videos.where(kind_of: 1)
    @private = @videos.where(kind_of:2)
    @other   = @videos.where(kind_of:3)
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

  def show
    @video = Video.find(params[:id])
    @videos = Video.all.order(updated_on:'desc')
    @related = @video.recommends
  end

  def edit
    @video = Video.find(params[:id])
  end

  def update
    @video = Video.find(params[:id])
    if @video.update(video_params)
      redirect_to video_path(@video)
    else
      render 'edit'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path
  end

  private
    def video_params
      params.require(:video).permit(:url,:title,:kind_of,:rate,:description,:highlight,:category,:quotes,:mvp,:editor,:updated_on,person_attributes:[:id,:name],person_ids: [],place_ids: [],penalty_ids: [],music_ids: [],tag_ids: [],recommend_ids: [])
    end

    def search_params
      params.require(:q).permit(:title_or_description_or_highlight_cont_or_rate_or_updated_on_cont)
    end

end
