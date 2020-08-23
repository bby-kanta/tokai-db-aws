class TagsController < ApplicationController
  before_action :manji, except: [:index,:show]
  before_action :twitter_client, only: [:create]
  
  def manji
    if user_signed_in?
      redirect_to action: :index unless current_user.id == 1
    else
      redirect_to action: :index
    end
  end

  def index
    @tags = Tag.joins(:tag_videos).group(:tag_id).order('count(video_id) desc')  # https://qiita.com/kent_ear/items/5748d6b6db83fb5e8782
  end

  def show
    @tag = Tag.find(params[:id])
    @videos = @tag.videos
  end

  def new
    @tag = Tag.new
  end

  def create
    # 人物のところにフォームあり
    person = Person.find(params[:person_id])
    @tag = person.tags.build(tag_params)
      if @tag.save
        @client.update("ハッシュタグ【#{@tag.name}】 を作成しました！ \n https://toukaionair.com/#/tags/#{@tag.id} \r")
        redirect_to tag_path(@tag)
      else
        render 'index'
      end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to tags_path
  end


  private
  def tag_params
    params.require(:tag).permit(:name,:description,:sort,:person_id)
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
