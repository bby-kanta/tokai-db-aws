class Video < ApplicationRecord

  has_many :users, through: :favorites
  has_many :favorites
  accepts_nested_attributes_for :favorites

  has_many :people, through: :person_videos
  has_many :person_videos

  has_many :places, through: :place_videos
  has_many :place_videos

  has_many :penalties,through: :panalty_videos
  has_many :penalty_videos

  has_many :tags,through: :tag_videos
  has_many :tag_videos

  has_many :musics,through: :music_videos
  has_many :music_videos
  
  # enum rate: [:C,:B,:A,:S]
  # ランク付け
  # enum mvp: [:'該当無し',:'てつや',:'しばゆー',:'りょう',:'としみつ',:'ゆめまる',:'虫眼鏡']
  # 一番活躍したメンバー
  # enum editor: [:'該当無し',:'てつや',:'しばゆー',:'りょう',:'としみつ',:'ゆめまる',:'虫眼鏡']
  # 編集者 初期のころは記載無し
end
