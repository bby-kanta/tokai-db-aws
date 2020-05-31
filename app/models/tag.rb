class Tag < ApplicationRecord

  has_many :tag_videos,dependent: :destroy
  has_many :videos,through: :tag_videos
  accepts_nested_attributes_for :tag_videos
  
  belongs_to :person
end
