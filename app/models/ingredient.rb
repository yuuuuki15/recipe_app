class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true, length: { maximum: 40 }
  validates :quantity, presence: true
end
