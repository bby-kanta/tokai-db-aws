class MusicsController < ApplicationController
  before_action :manji, except: [:index,:show]

  def manji
    if user_signed_in?
      redirect_to action: :index unless current_user.id == 1
    else
      redirect_to action: :index
    end
  end
  
  def index
    @searches = Music.ransack(params[:q])
    @musics = Music.all.order(created_at:'asc')
  end

  def search
    @searches = Music.ransack(params[:q])
    @musics = @searches.result.order(created_at: 'desc')
    render 'index'
  end

  def show
    @music = Music.find(params[:id])
    @musics = Music.all.sample(10)
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

  def edit
    @music = Music.find(params[:id])
  end

  def update
    @music = Music.find(params[:id])
    if @music.update(music_params)
      redirect_to musics_path
    else
      render 'edit'
    end
  end

  def destroy
    @music = Music.find(params[:id])
    @music.destroy
    redirect_to musics_path
  end

  private
  def music_params
    params.require(:music).permit(:name,:description,:url)
  end

  def search_params
    params.require(:q).permit(:name_cont_or_description_cont)
  end

end
