class Step < ApplicationRecord
  default_scope { sort(id: 'ASC') }

  belongs_to :story
  has_many :frames
end
