class TagVideo < ApplicationRecord

  belongs_to :tag
  belongs_to :video

end
