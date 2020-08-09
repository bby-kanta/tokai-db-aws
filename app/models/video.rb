class Video < ApplicationRecord

  has_many :comments,dependent: :destroy
  has_many :users, through: :comments

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
  has_many :recommends, through: :relationships

  def random_tags
    tags.select(:id,:name).sample(4)
  end

  def users_id_select
    users.select(:id)
  end

end
