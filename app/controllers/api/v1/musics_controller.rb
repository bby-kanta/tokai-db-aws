class Api::V1::MusicsController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @musics = Music.joins(:music_videos).group(:music_id).order('count(video_id) desc')
    render json: @musics.to_json(except: [:description,:created_at,:updated_at],include:{videos: {only: [:id]}})
  end

  def show
    @music = Music.find(params[:id])
    render json: @music.to_json(include: {videos:{only:[:id,:title,:url,:kind_of,:rate,:mvp,:updated_on],include: {users:{only:[:id]}}, methods: :random_tags } } ) 
  end

  def create
    Music.create!(music_params)
    head :created
  end

  def all
    render json: Music.select(:id,:name,:url)
  end

  private

  def music_params
    params.require(:music).permit(:name,:description,:url)
  end

end