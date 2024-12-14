FactoryBot.define do
  factory :ticket do
    title { "Sample Ticket" }
    description { "This is a description for the ticket." }
    due_date { 1.day.from_now }
    progress { 0 }
    status
    assigned_user

    # Trait for assigned_user
    trait :assigned_user do
      assigned_user_id { create(:user).id }
    end
  end
end
