class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites,dependent: :destroy
  has_many :videos, through: :favorites

  def already_favorited?(video)
    self.favorites.exists?(video_id: video.id)
  end

end