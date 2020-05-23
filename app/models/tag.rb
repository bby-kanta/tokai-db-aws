class Tag < ApplicationRecord

  has_many :videos,through: :tag_videos
  has_many :tag_videos
  accepts_nested_attributes_for :tag_videos

end
