class Menu < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :date, presence: true
end
