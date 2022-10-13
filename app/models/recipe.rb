class Recipe < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  scope :by_user, ->(user) { where(user:) }

  validate :image_type

  private

  def image_type
    errors.add(:image, "Error: Please upload an image with one of the following extensions: jpeg, jpg, png, or webp!") unless image.content_type.in?(%w[image/png image/jpeg image/jpg image/webp])
  end
end
