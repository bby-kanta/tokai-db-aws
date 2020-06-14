class TagsController < ApplicationController
  before_action :manji, except: [:index,:show]
  
  def manji
    if user_signed_in?
      redirect_to action: :index unless current_user.id == 1
    else
      redirect_to action: :index
    end
  end

  def index
    @searches = Tag.ransack(params[:q])
    @tags = Tag.joins(:tag_videos).group(:tag_id).order('count(video_id) desc')  # https://qiita.com/kent_ear/items/5748d6b6db83fb5e8782
  end

  def search
    @searches = Tag.ransack(params[:q])
    @tags = @searches.result.joins(:tag_videos).group(:tag_id).order('count(video_id) desc') 
    render 'index'
  end

  def show
    @tag = Tag.find(params[:id])
    @videos = @tag.videos
  end

  def new
    @tag = Tag.new
  end

  def create
    # 人物のところにフォームあり
    person = Person.find(params[:person_id])
    tag = person.tags.build(tag_params)
      if tag.save
        redirect_to tags_path
      else
        render 'index'
      end
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])
    if @tag.update(tag_params)
      redirect_to tags_path
    else
      render 'edit'
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    redirect_to tags_path
  end


  private
  def tag_params
    params.require(:tag).permit(:name,:description,:person_id)
  end

  def search_params
    params.require(:q).permit(:name_cont_or_description_cont)
  end

end
