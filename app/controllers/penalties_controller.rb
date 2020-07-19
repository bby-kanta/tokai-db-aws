class PenaltiesController < ApplicationController
  before_action :manji, except: [:index,:show,:search]

  def manji
    if user_signed_in?
      redirect_to action: :index unless current_user.id == 1
    else
      redirect_to action: :index
    end
  end


  def index
    @searches = Penalty.ransack(params[:q])
    @penalties = Penalty.all.order(since:'desc')
  end

  def search
    @searches = Penalty.ransack(params[:q])
    @penalties = @searches.result.joins(:penalty_videos).group(:penalty_id).order('count(video_id) desc') 
    render 'index'
  end

  def show
    @penalty = Penalty.find(params[:id])
    @penalties = Penalty.all.sample(10)
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

  def search_params
    params.require(:q).permit(:name_cont_or_description_cont)
  end

end
