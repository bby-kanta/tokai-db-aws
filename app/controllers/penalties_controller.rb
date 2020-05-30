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
    # 人物のところにフォームあり
    person = Person.find(params[:person_id])
    penalty = person.penalties.build(penalty_params)
      if penalty.save
        redirect_to penalties_path
      else
        render 'index'
      end
  end

  def edit
    @penalty = Penalty.find(params[:id])
  end

  def update
    @penalty = Penalty.find(params[:id])
    if @penalty.update(penalty_params)
      redirect_to penalties_path
    else
      render 'edit'
    end
  end

  def destroy
    @penalty = Penalty.find(params[:id])
    @penalty.destroy
    redirect_to penalties_path
  end


  private
  def penalty_params
    params.require(:penalty).permit(:name,:description,:since,:person_id)
  end

end
