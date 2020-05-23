class PersonVideo < ApplicationRecord
  belongs_to :person
  belongs_to :video
end
