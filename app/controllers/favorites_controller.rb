class FavoritesController < ApplicationController
  def create
    @video    = Video.find(params[:video_id])
    @favorite = current_user.favorites.create(video_id: params[:video_id])
    # redirect_back(fallback_location: root_path)
  end

  def destroy
    @video    = Video.find(params[:video_id])
    @favorite = current_user.favorites.find_by(video_id: @video.id)
    @favorite.destroy
    # redirect_back(fallback_location: root_path)
  end

end