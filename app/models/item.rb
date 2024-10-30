class Item < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
end
