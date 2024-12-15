class SendDueDateReminderJob
  include Sidekiq::Job

  def perform(ticket_id)
    ticket = Ticket.find(ticket_id)
    return unless ticket&.assigned_user

    # Send the email to the user
    UserMailer.due_date_reminder(ticket).deliver_later

    # Create the notification after the email is sent
    create_notification(ticket)
  end

  private

  def create_notification(ticket)
    Notification.create(
      user: ticket.assigned_user,
      ticket: ticket,
      message: "Reminder: Your ticket '#{ticket.title}' is due in #{ticket.due_date - Date.today} days."
    )
  end
end
