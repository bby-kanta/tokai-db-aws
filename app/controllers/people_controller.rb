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

    @tag = @person.tags.build
  end

  private
  def person_params
    params.require(:person).permit(:name,:description)
  end

end
