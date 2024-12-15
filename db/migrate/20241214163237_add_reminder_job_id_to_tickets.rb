class AddReminderJobIdToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :reminder_job_id, :string
  end
end
