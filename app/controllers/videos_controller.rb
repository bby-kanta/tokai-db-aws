class VideosController < ApplicationController

  before_action :manji, except: [:index,:show,:search]
  before_action :twitter_client, only: [:create]


  def manji  #管理者以外はCRUD不可
    if user_signed_in?
      redirect_to action: :index unless current_user.id == 1
    else
      redirect_to action: :index
    end
  end

  def index
  end

  def search  #ransack用アクション
    @search = Video.ransack(params[:q])
    @all_videos = @search.result
  end

  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)
    if @video.save
      @client.update("記事を投稿しました! \n\n タイトル：#{@video.title} \n ランク：#{@video.rating} \n MVP：#{@video.mvp_name} \n 動画投稿日：#{@video.updated_on} \n https://toukaionair.com/#/videos/#{@video.id} \r")  #https://github.com/sferik/twitter/blob/master/examples/Update.md#update
      redirect_to video_path(@video)
    else
      render 'new'
    end
  end

  def show
    @video   = Video.find(params[:id])
    @videos  = Video.all.order(updated_on:'desc')
    @related = @video.recommends
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
      params.require(:video).permit(:url,:title,:kind_of,:rate,:description,:highlight,:category,:quotes,:mvp,:editor,:sort,:updated_on,person_attributes:[:id,:name],person_ids: [],place_ids: [],penalty_ids: [],music_ids: [],tag_ids: [],recommend_ids: [])
    end

    def search_params
      params.require(:q).permit(:title_cont_or_description_or_highlight_cont_or_rate_or_updated_on_cont_or_updated_on_lteq_or_category_eq_or_mvp_eq)
    end

    def twitter_client
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = Rails.application.credentials.twitter[:api_key]
        config.consumer_secret     = Rails.application.credentials.twitter[:api_secret_key]
        config.access_token        = Rails.application.credentials.twitter[:access_token]
        config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
      end
    end

end
