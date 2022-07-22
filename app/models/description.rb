class Description < ApplicationRecord
  belongs_to :recipe

  validates :text, presence: true, length: { maximum: 100 }
end
