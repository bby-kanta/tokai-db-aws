class PlaceVideo < ApplicationRecord
  belongs_to :place
  belongs_to :video
end
