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

  def users_id_map  #"users":[{"id":1},{"id":2}] となっていたものを"users_id_map":[1,2]とする。
    users.map {|x| x.id}
  end

  def rating
    if rate == 1
      return "S"
    elsif rate == 2 
      return "A"
    elsif rate == 3 
      return "B"
    else
      return "C"
    end

  end

  def mvp_name
    if mvp == 1
      return "てつや"
    elsif mvp == 2 
      return "しばゆー"
    elsif mvp == 3 
      return "りょう"
    elsif mvp == 4
      return "としみつ"
    elsif mvp == 5
      return "ゆめまる"
    elsif mvp == 6
      return "虫眼鏡"
    else
      return "該当者なし"
    end

  end

end
