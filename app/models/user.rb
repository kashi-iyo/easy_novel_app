class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable, omniauth_providers: [:twitter]
  has_secure_password

  validates :password_digest, presence: true
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :posts

  has_one_attached :image
end
