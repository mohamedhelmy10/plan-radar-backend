class Ticket < ApplicationRecord
  # Associations
	belongs_to :assigned_user, class_name: 'User', foreign_key: 'assigned_user_id', required: true
  belongs_to :status

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :assigned_user_id, presence: true
	validates :status_id, presence: true
	validates :due_date, presence: true
	validates :progress, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100,
    only_integer: true,
    message: "must be an integer between 0 and 100" 
  }

	validate :due_date_not_in_the_past

	private

  def due_date_not_in_the_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "can't be in the past")
    end
  end
end
