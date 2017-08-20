class Answer < ApplicationRecord
  belongs_to :participation
  has_one :question
  has_and_belongs_to_many :choices
end
