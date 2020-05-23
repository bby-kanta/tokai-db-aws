class Penalty < ApplicationRecord

  has_many :videos,through: :panalty_videos
  has_many :penalty_videos
  accepts_nested_attributes_for :place_videos

  belongs_to :person

end
