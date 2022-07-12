class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :date, presence: true
  validates :user_id, presence: true
  validates :recipe_id, presence: true
end
