class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attachment :image

  with_options presence: true do
    validates :title, length: { maximum: 40 }
    validates :amount, numericality: { other_than: 0, message: "can't be blank" }
    validates :method, length: { maximum: 1000 }
    validates :public_id
    validates :user_id, numericality: { other_than: 0, message: "can't be blank" }
  end

  validates :tip, length: { maximum: 1000 }
end
