class Api::V1::PenaltiesController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @penalties = Penalty.select(:id,:name,:person_id,:since).order(since: 'desc')
    render json: @penalties.to_json(except: [:description,:sort,:penalty_image_id,:created_at,:updated_at],include:{videos: {only: [:id]}})
    # render json: Penalty.select(:id,:name,:person_id,:since).order(since: 'desc')
  end

  def show
    @penalty = Penalty.find(params[:id])
    render json: @penalty.to_json(include: {videos:{only:[:id,:title,:url,:kind_of,:rate,:mvp,:updated_on],include: {users:{only:[:id]}}, methods: :random_tags } } ) 
  end

end