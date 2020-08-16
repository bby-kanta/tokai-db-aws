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
    if user_signed_in?
      videos = current_user.videos.order(created_at:'desc').eager_load(:tags).page(params[:page]).per(40)
      pagenation = resources_with_pagination(videos)  #pagenation_controllerにて定義
      @videos = videos.as_json(include: [users:{only:[:id]}],methods: [:random_tags])
      object = { videos: @videos, kaminari: pagenation } 
      render json: object
    else
      @user = 'none'
      render json: @user
    end

  end

  def recommend
  end

end