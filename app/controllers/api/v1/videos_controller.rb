class Api::V1::VideosController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    tags = Video.order(updated_on:'desc').eager_load(:tags)
    # videos = tags.as_json(:include => {:tags => {:only => [:id, :name]},:users})
    # @videos = tags.as_json(include: [{tags: {only: [:id, :name]}},users:{only:[:id]}],methods: :_tags)
    @videos = tags.as_json(include: [users:{only:[:id]}],methods: :random_tags)
    render json: @videos
  end

  def show
    @video = Video.find(params[:id])
    render json: @video.to_json(include: [ {comments:{include:{user: {only:[:id,:name]}},except:[:updated_at]}} , {people:{only: [:id,:name]}},{penalties:{only: [:id,:name,:person_id]}},{places:{only: [:id,:name]}},{musics:{only: [:id,:name]}},{tags:{only: [:id,:person_id,:name]}},{users:{only: [:id]}},{recommends: {include: [tags:{only: [:id,:name]} , users:{only: [:id]}],except: [:description,:highlight,:created_at,:updated_at,:sort],methods: :random_tags }}])
  end

  def recommend
    tags = Video.order(updated_on:'desc').eager_load(:tags).sample(40)
    @videos = tags.as_json(include: [users:{only:[:id]}],methods: :random_tags)
    render json: @videos
  end

end
