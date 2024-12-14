class User < ApplicationRecord
  # Associations
  has_many :notifications
  has_many :tickets, foreign_key: :assigned_user_id

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
	validates :time_zone, presence: true
  validate :valid_time_zone

	private

  def valid_time_zone
    begin
      TZInfo::Timezone.get(time_zone)
    rescue TZInfo::InvalidTimezoneIdentifier
      errors.add(:time_zone, "is not a valid time zone")
    end
  end
end
