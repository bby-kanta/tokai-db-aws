class PenaltiesController < ApplicationController

  def index
    @penalties = Penalty.all.order(created_at:'desc')
  end

  def show
    @penalty = Penalty.find(params[:id])
  end

  def new
    @penalty = Penalty.new
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

  #     @tag = Tag.new(tag_params)
  #       if @tag.save
  #         redirect_to tags_path
  #       else
  #         render 'new'
  #       end
  end


  private
  def penalty_params
    params.require(:penalty).permit(:name,:description,:since,:person_id)
  end

end
