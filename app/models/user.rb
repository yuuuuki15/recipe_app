class User < ApplicationRecord
  has_many :recipes, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
end
