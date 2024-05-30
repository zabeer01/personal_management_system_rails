class Item < ApplicationRecord
    belongs_to :user
    
    #image
    has_one_attached :image_url
    
    #field details 
    has_many :field_details
    accepts_nested_attributes_for :field_details
    has_many :user_items
    has_many :users, through: :user_items
end