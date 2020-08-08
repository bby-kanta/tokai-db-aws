class Api::V1::UsersController < ApiController

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
  end

  def recommend
  end

end