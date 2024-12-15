class User < ApplicationRecord
  # Associations
  has_many :notifications, dependent: :destroy
  has_many :tickets, dependent: :destroy, foreign_key: :assigned_user_id

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
	validates :time_zone, presence: true
  validate :valid_time_zone

	# Callbacks
	after_save :reschedule_due_date_reminders, if: -> { due_date_reminder_settings_changed? }

	private

  def valid_time_zone
    begin
      TZInfo::Timezone.get(time_zone)
    rescue TZInfo::InvalidTimezoneIdentifier
      errors.add(:time_zone, "is not a valid time zone")
    end
  end

	def due_date_reminder_settings_changed?
		saved_change_to_send_due_date_reminder? ||
    saved_change_to_due_date_reminder_interval? ||
    saved_change_to_due_date_reminder_time? ||
		saved_change_to_time_zone?
  end

	def reschedule_due_date_reminders
		tickets.each(&:schedule_due_date_reminder)
	end
	
end
