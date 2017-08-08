class Step < ApplicationRecord
  belongs_to :story
  has_many :frames
end
