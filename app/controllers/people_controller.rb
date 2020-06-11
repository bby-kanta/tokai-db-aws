class PeopleController < ApplicationController

  def index
    @searches = Person.ransack(params[:q])
    @people = Person.all.order(id:'asc')
  end

  def search
    @searches = Person.ransack(params[:q])
    @people = @searches.result.order(created_at: 'desc')
    render 'index'
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
      if @person.save
        redirect_to people_path
      else
        render 'new'
      end
  end

  def show
    @person = Person.find(params[:id])

    @tags = @person.tags.all
    # .allを付けない場合 tag_path(tag.id) でエラーがでる(5/27)スラックで質問済み。url genarate error.

    @tag = @person.tags.build

    @penalties = @person.penalties.all

    @penalty = @person.penalties.build
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to people_path
    else
      render 'edit'
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to videos_path
  end

  private
  def person_params
    params.require(:person).permit(:name,:description)
  end

  def search_params
    params.require(:q).permit(:name_cont_or_description_cont)
  end

end
