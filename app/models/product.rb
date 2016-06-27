class Product < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  validates_presence_of :name, :price
  validates_numericality_of :price # to ensure price should be a number
end
