FactoryBot.define do
  factory :ticket do
    title { "Sample Ticket" }
    description { "This is a description for the ticket." }
    due_date { 1.day.from_now }
    progress { 0 }
    status { Status.first || create(:status) }
    assigned_user

    # Trait for assigned_user with a unique email
    trait :assigned_user do
      assigned_user { create(:user) }
    end
  end
end
