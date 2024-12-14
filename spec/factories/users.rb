FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "john.doe@example.com" }
    send_due_date_reminder { false }
    due_date_reminder_interval { 0 }
    due_date_reminder_time { "09:00" }
    time_zone { "Europe/Vienna" }
  end
end
