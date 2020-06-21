class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :video

  validates_uniqueness_of :video_id,scope: :user_id #ユーザーは一つの投稿に一つまでいいねできる。
end
