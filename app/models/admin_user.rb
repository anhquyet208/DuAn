class AdminUser < ApplicationRecord
  acts_as_paranoid
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable
end
