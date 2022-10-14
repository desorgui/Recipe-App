class Food < ApplicationRecord
  has_many :inventory_foods, dependent: :destroy
  has_many :inventories, through: :inventory_foods
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  has_one_attached :image

  validate :image_type

  private

  def image_type
    if image.attached?
      errors.add(:image, "Error: Please upload an image with one of the following extensions: jpeg, jpg, png, or webp!") unless image.content_type.in?(%w[image/png image/jpeg image/jpg image/webp])
    end
  end
end
