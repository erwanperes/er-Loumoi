class Reservation < ApplicationRecord
  belongs_to :borrower, class_name: 'User'
  belongs_to :item

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_after_start_date
  validate :item_available

  enum status: { pending: 0, approved: 1, rejected: 2, active: 3, returned: 4, cancelled: 5 }

  private

  def end_date_after_start_date
	return if end_date.blank? || start_date.blank?
	errors.add(:end_date, "must be after the start date") if end_date < start_date
  end

  def item_available
	return unless item && start_date && end_date
	unless item.available?(start_date, end_date)
	  errors.add(:base, "The item is not available for the requested period")
	end
  end
end