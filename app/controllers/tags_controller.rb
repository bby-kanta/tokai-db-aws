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
    人物のところにフォームあり
    person = Person.find(params[:person_id])
    penalty = person.penalties.build(penalty_params)
      if penalty.save
        redirect_to penalties_path
      else
        render 'index'
      end
  end


  private
  def penalty_params
    params.require(:penalty).permit(:name,:description,:person_id)
  end

end
