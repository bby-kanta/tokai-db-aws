class Music < ApplicationRecord

  has_many :videos,through: :music_videos
  has_many :music_videos
  accepts_nested_attributes_for :music_videos
  
end
