class Inventory < ApplicationRecord
  belongs_to :user

  has_many :inventory_foods, dependent: :destroy
  has_many :foods, through: :inventory_foods

  validates :description, presence: true
  validates :name, presence: true
end
