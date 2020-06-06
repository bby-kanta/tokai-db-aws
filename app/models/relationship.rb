class Relationship < ApplicationRecord
  belongs_to :video
  belongs_to :recommend, class_name: 'Video'

  validates :video_id, presence: true
  validates :recommend_id, presence: true
end
