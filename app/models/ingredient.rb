class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true, if: :quantity?
  validates :quantity, presence: true, if: :name?
end
