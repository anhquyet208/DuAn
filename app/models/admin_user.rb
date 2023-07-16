class AdminUser < ApplicationRecord
  acts_as_paranoid
  # has_many :admin_user, dependent: :destroy
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
