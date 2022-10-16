class Recipe < ApplicationRecord
  belongs_to :user

  has_one_attached :image
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  scope :by_user, ->(user) { where(user:) }

  validate :image_type
  validates :preparation_time, numericality: { only_float: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, numericality: { only_float: true, greater_than_or_equal_to: 0 }

  private

  def image_type
    return unless image.attached?

    image_types = %w[
      image/png image/jpeg image/jpg image/webp
    ]

    return if image.content_type.in?(image_types)

    errors.add(:image,
               'Error: Please upload an image with one of the following extensions: jpeg, jpg, png, or webp!')
  end
end
