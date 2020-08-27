class TagVideo < ApplicationRecord

  belongs_to :tag
  belongs_to :video

  validates_uniqueness_of :video_id,scope: :tag_id
end