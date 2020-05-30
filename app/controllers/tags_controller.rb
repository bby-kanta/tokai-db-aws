class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(created_at:'desc')
  end

  def show
    @tag = Tag.find(params[:id])
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

end
