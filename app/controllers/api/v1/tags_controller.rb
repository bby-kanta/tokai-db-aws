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
    render json: @tag.to_json(include: {videos:{only:[:id,:title,:url,:kind_of,:rate,:mvp,:updated_on],include: {users:{only:[:id]}}, methods: :random_tags } } ) 
  end

  def create
    # current_user.favorites.create!(video_id: params[:video_id])
    # @person = Person.find(params[:id])
    @tags = current_user.tags.create!(tag_params)
    # @tags.update!(person_id: @person.id)
    head :created
  end

  private

  def tag_params
    params.require(:tag).permit(:user_id,:name,:description,:sort,:person_id)
  end

end