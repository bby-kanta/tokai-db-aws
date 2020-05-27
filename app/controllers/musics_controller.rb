class MusicsController < ApplicationController
  def index
    @musics = Music.all.order(created_at:'asc')
  end

  def show
    @music = Music.find(params[:id])
  end

  def new
    @music = Music.new
  end

  def create
    @music = Music.new(music_params)
      if @music.save
        redirect_to musics_path
      else
        render 'new'
      end
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    redirect_to musics_path
  end

  private
  def music_params
    params.require(:music).permit(:name,:description)
  end

end
