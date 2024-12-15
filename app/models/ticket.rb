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

	# Callbacks
	after_save :schedule_due_date_reminder, if: -> { saved_change_to_due_date? }

	def schedule_due_date_reminder
    cancel_existing_job if reminder_job_id.present?
		unless assigned_user&.send_due_date_reminder
			self.reminder_job_id = nil
			self.save
			return
		end

    reminder_time = calculate_reminder_time
    # Schedule the new reminder job
    self.reminder_job_id = SendDueDateReminderJob.perform_at(reminder_time, self.id)
		self.save
  end

	private

	def due_date_not_in_the_past
    errors.add(:due_date, "can't be in the past") if due_date.present? && due_date < Date.today
  end

	def cancel_existing_job
    Sidekiq::ScheduledSet.new.find_job(reminder_job_id)&.delete if reminder_job_id.present?
  end

	def calculate_reminder_time
		user_time_zone = TZInfo::Timezone.get(assigned_user.time_zone) rescue TZInfo::Timezone.get('Europe/Vienna')
		# Calculate reminder time in user's time zone
		reminder_time_in_user_tz = due_date.to_time - assigned_user.due_date_reminder_interval.days
		reminder_time_in_user_tz = reminder_time_in_user_tz.change(hour: assigned_user.due_date_reminder_time.hour, 
																															 min: assigned_user.due_date_reminder_time.min)
		# Convert reminder time back to UTC for scheduling
		user_time_zone.local_to_utc(reminder_time_in_user_tz)
	end
end
