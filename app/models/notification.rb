class Notification < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :ticket

  # Validations
  validates :message, presence: true
  validates :sent_at, presence: true
  validates :notification_type, presence: true

  # Enum for notification types
  enum notification_type: { email: 0, sms: 1, push_message: 2 }
end
