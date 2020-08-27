class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :comments,dependent: :destroy
  has_many :videos, through: :comments
         
  has_many :favorites,dependent: :destroy
  has_many :videos, through: :favorites

  has_many :tags,dependent: :destroy


  def already_favorited?(video)
    self.favorites.exists?(video_id: video.id)
  end

  def self.guest  #テストログイン機能 https://qiita.com/rie1224/items/5f8c88bca9f56c582f52
    find_or_create_by(email: "test@com" , name: "test123") do |user|
      user.password = 12345678
    end
  end

end