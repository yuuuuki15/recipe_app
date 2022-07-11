class Description < ApplicationRecord
  belongs_to :recipe

  validates :texts, presence: true
end
