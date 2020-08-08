class Api::V1::FavoritesController < ApiController

  def index
    favorites = Favorite.all
    @favorites = favorites.as_json(only: [:id,:video_id , :user_id])
    render json: @favorites
  end
    
  def create
    current_user.favorites.create(video_id: params[:video_id])
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.favorites.find(params[:id]).destroy!
  end

end