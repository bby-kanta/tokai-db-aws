class Person < ApplicationRecord

  has_many :videos,through: :person_videos
  has_many :person_videos
  accepts_nested_attributes_for :person_videos
  # 他のモデルを一括で更新、保存できるようにする。ここではpersonを保存するのと同時にperson_videosを更新できるようにしています。
  has_many :penalties

end
