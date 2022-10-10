class User < ApplicationRecord
  has_many :inventories, foreign_key: 'inventory_id', dependent: :destroy
  has_many :recipes, dependent: :destroy
end