class UserMailer < ApplicationMailer
  def due_date_reminder(ticket)
    @ticket = ticket
    @user = ticket.assigned_user
    mail(to: @user.email, subject: 'Task Due Date Reminder')
  end
end
