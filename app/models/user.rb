class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :rooms, dependent: :destroy
  has_many :reservations, dependent: :destroy

  
  mount_uploader :avatar, AvatarUploader
  
  validates :name, presence: true
  #validates :email, uniqueness: true, presence: true
  #validates :password, presence: true, confirmation: true
  #validates :password_confirmation, presence: true
  
  validates :introduction, length: {maximum: 200}, on: :update
  
end
