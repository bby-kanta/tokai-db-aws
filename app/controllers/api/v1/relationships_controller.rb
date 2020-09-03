class Api::V1::RelationshipsController < ApiController

  def index
    render json: Relationship.select(:id, :video_id, :recommend_id)
  end

  def create
    Relationship.create!(relationship_params)
  end

  def destroy
    Relationship.find(params[:id]).destroy!
    head :ok
  end


  private

  def relationship_params
    params.require(:relationship).permit(:video_id,:recommend_id)
  end

end