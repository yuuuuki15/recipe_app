class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :menus, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
end
