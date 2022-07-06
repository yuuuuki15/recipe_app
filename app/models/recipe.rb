class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_many :ingredients, dependent: :destroy
end
