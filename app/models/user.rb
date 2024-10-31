class User < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :borrower_reservations, class_name: 'Reservation', foreign_key: 'user_id', dependent: :destroy
  has_many :lender_reservations, class_name: 'Reservation', foreign_key: 'user_id', dependent: :destroy

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
end
