class Place < ApplicationRecord

  has_many :place_videos,dependent: :destroy
  has_many :videos, through: :place_videos
  accepts_nested_attributes_for :place_videos
  
end
