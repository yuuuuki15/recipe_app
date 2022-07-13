class List < ApplicationRecord
  belongs_to :user

  validates :ingredient_name, presence: true
end
