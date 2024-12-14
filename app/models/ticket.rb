class Ticket < ApplicationRecord
  # Associations
  belongs_to :assigned_user, class_name: 'User', foreign_key: 'assigned_user_id', optional: true
  belongs_to :status

  # Validations
  validates :title, presence: true
  validates :description, presence: true
  validates :due_date, presence: true
  validates :assigned_user_id, presence: true
end
