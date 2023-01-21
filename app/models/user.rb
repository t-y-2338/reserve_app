class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true
  #validates :email, uniqueness: true, presence: true
  #validates :password, presence: true, confirmation: true
  #validates :password_confirmation, presence: true
  
  validates :introduction, length: {maximum: 200}, on: :update
  
end
