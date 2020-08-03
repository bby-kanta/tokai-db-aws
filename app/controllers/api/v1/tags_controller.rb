class Api::V1::TagsController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    @tags = Tag.joins(:tag_videos).group(:tag_id).order('count(video_id) desc')  # https://qiita.com/kent_ear/items/5748d6b6db83fb5e8782
    render json: @tags.to_json(except: [:description,:sort,:tag_image_id,:created_at,:updated_at],include:{videos: {only: [:id]}})
  end

  def show
    @tag = Tag.find(params[:id])
    render json: @tag.to_json(include: {videos:{only:[:id,:title,:url,:rate,:mvp,:updated_on] , include:{tags:{only: [:id,:name,:person_id]}} , methods: :random_tags } } ) 
  end

end