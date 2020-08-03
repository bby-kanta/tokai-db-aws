class Api::V1::PeopleController < ApiController

  # ActiveRecordのレコードが見つからなければ404 not foundを応答する
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    people = Person.all.order(id: 'asc')
    @people = people.as_json(include: [videos:{only:[:id]}])
    render json: @people
  end

  def show
    @person = Person.find(params[:id])
    render json: @person.to_json(include: [{penalties:{only: [:id,:name,:person_id]}},{tags:{only: [:id,:person_id,:name]}},{videos:{only:[:id,:title,:url,:rate,:mvp,:updated_on] , methods: :random_tags } }  ])
  end

end