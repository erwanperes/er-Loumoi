class Item < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  
  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 300 }
  validates :category, presence: true
  validates :user_id, presence: true
end
