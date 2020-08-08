class Api::V1::PlacesController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @places = Place.joins(:place_videos).group(:place_id).order('count(video_id) desc')
    render json: @places.to_json(except: [:description,:created_at,:updated_at],include:{videos: {only: [:id]}})
  end

  def show
    @place = Place.find(params[:id])
    render json: @place.to_json(include: {videos:{only:[:id,:title,:url,:kind_of,:rate,:mvp,:updated_on],include: {users:{only:[:id]}}, methods: :random_tags } } ) 
  end

end