class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image, dependent: :destroy
  has_many :ingredients, dependent: :destroy, inverse_of: :recipe
  accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
  has_many :descriptions, dependent: :destroy, inverse_of: :recipe
  accepts_nested_attributes_for :descriptions, reject_if: :all_blank, allow_destroy: true
  has_many :menus, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :amount, numericality: { other_than: 0, allow_blank: true }
    validates :public_id
  end
  validates :tip, length: { maximum: 1000 }
end
