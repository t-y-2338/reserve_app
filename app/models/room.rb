class Room < ApplicationRecord
  belongs_to :user

  
  mount_uploader :image, ImageUploader
  
  validates :room_name, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :address, presence: true

end
