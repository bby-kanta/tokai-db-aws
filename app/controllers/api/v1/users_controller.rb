class Api::V1::UsersController < ApiController
  include Pagenation

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    if user_signed_in?
      @user = current_user.id
      render json: @user
    else
      @user = 'none'
      render json: @user
    end

  end

  def show
      user = User.find(params[:id])
      videos = user.videos.order(created_at:'desc').eager_load(:tags).page(params[:page]).per(40)
      pagenation = resources_with_pagination(videos)  #pagenation_controllerにて定義
      @videos = videos.as_json(include: [users:{only:[:id]}],methods: [:random_tags])
      @tags = current_user.tags.order(sort:'asc').as_json(only: [:id,:name,:sort,:person_id,:user_id])
      object = { videos: @videos, kaminari: pagenation ,user: user ,tags: @tags} 
      render json: object
  end

  def recommend
  end

end