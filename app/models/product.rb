class Product < ApplicationRecord
	belongs_to :category
	belongs_to :user
	validates_presence_of :product_name
	validates :product_name, uniqueness: true
end
