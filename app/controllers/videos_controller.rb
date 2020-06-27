class VideosController < ApplicationController

  before_action :manji, except: [:index,:show,:search]


  def manji
    if user_signed_in?
      redirect_to action: :index unless current_user.id == 1
    else
      redirect_to action: :index
    end
  end

  def index
    @all_videos  = Video.all.order(updated_on:'desc')
    @videos  = @all_videos.page(params[:page]).per(40)
    @main    = @all_videos.where(kind_of: 0).page(params[:page]).per(40)
    @sub     = @all_videos.where(kind_of: 1).page(params[:page]).per(40)
    @private = @all_videos.where(kind_of: 2).page(params[:page]).per(40)
    @other   = @all_videos.where(kind_of: 3).page(params[:page]).per(40)
  end

  def search
    @search = Video.ransack(params[:q])
    @all_videos = @search.result
    @videos  = @search.result.page(params[:page]).per(40).order(updated_on: 'desc')
    @main    = @videos.where(kind_of: 0).page(params[:page]).per(40)
    @sub     = @videos.where(kind_of: 1).page(params[:page]).per(40)
    @private = @videos.where(kind_of: 2).page(params[:page]).per(40)
    @other   = @videos.where(kind_of: 3).page(params[:page]).per(40)
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
    @related = @video.recommends.order(created_at:'asc')
    @tetsuya     = @video.people.find_by(name:'てつや')
    @shibayu     = @video.people.find_by(name:'しばゆー')
    @ryo         = @video.people.find_by(name:'りょう')
    @toshimitsu  = @video.people.find_by(name:'としみつ')
    @yumemaru    = @video.people.find_by(name:'ゆめまる')
    @mushimegane = @video.people.find_by(name:'虫眼鏡')
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
      params.require(:q).permit(:title_cont_or_description_or_highlight_cont_or_rate_or_updated_on_cont_or_updated_on_lteq_or_category_eq_or_mvp_eq)
    end

end
