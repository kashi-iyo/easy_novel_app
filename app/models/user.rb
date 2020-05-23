class User < ApplicationRecord
  has_secure_password

  validates :password_digest, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts

  has_one_attached :image
end
