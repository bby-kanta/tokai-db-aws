class UsersController < ApplicationController
  def show
    @video = current_user.videos.order(created_at:'desc')
  end
end
