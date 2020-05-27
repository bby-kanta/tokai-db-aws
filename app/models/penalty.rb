class Penalty < ApplicationRecord

  has_many :videos,through: :penalty_videos
  has_many :penalty_videos
  accepts_nested_attributes_for :penalty_videos

  belongs_to :person

end
