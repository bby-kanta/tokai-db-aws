class Api::V1::FavoritesController < ApiController

  def index
    # favorites = Favorite.all
    # @favorites = favorites.as_json(only: [:id,:video_id , :user_id])
    # render json: @favorites

    render json: Favorite.filter_by_video(params[:video_id]).select(:id, :user_id, :video_id)
  end
    
  def create
    # current_user.favorites.create!(video_id: params[:video_id])
    current_user.favorites.create!(favorites_params)
    head :created
  end

  def destroy
    current_user.favorites.find(params[:id]).destroy!
    head :ok
  end


  private

  def favorites_params
    params.require(:favorite).permit(:video_id)
  end

end