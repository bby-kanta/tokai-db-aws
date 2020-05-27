class PeopleController < ApplicationController

  def index
    @people = Person.all.order(id:'asc')
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

  private
  def person_params
    params.require(:person).permit(:name,:description)
  end

end
