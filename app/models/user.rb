class User < ApplicationRecord
  # Associations
  has_many :notifications
  has_many :tickets, foreign_key: :assigned_user_id

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is not a valid email" }
	validates :time_zone, presence: true
  validate :valid_time_zone

	# Callbacks
	after_save :reschedule_due_date_reminders, if: :due_date_reminder_settings_changed?

	private

  def valid_time_zone
    begin
      TZInfo::Timezone.get(time_zone)
    rescue TZInfo::InvalidTimezoneIdentifier
      errors.add(:time_zone, "is not a valid time zone")
    end
  end

	def due_date_reminder_settings_changed?
    send_due_date_reminder_changed? ||
      due_date_reminder_interval_changed? ||
      due_date_reminder_time_changed?
  end

	def reschedule_due_date_reminders
    return unless send_due_date_reminder

    tickets.each(&:schedule_due_date_reminder)
  end
end
