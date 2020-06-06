class Video < ApplicationRecord

  has_many :favorites,dependent: :destroy
  has_many :users, through: :favorites
  accepts_nested_attributes_for :favorites

  has_many :person_videos,dependent: :destroy
  has_many :people, through: :person_videos

  has_many :place_videos,dependent: :destroy
  has_many :places, through: :place_videos
  
  has_many :music_videos,dependent: :destroy
  has_many :musics,through: :music_videos

  has_many :penalty_videos,dependent: :destroy
  has_many :penalties,through: :penalty_videos

  has_many :tag_videos,dependent: :destroy
  has_many :tags,through: :tag_videos

  has_many :relationships,dependent: :destroy
  # has_many :relationships,dependent: :destroy
  has_many :recommends, through: :relationships
  # has_many :videos, through: :relationships

end
