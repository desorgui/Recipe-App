class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :inventories, foreign_key: 'inventory_id', dependent: :destroy
  has_many :recipes, dependent: :destroy

  enum role: %i[user moderator admin]

  after_initialize :set_default_role, if: :new_record?

  def is?(role)
    self.role == role.to_s
  end

  def moderator?
    is? :moderator
  end

  def admin?
    is? :admin
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
