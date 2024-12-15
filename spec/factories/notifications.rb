FactoryBot.define do
  factory :notification do
    message { "Test notification" }
    sent_at { Time.now }
    notification_type { :email }
    association :user, factory: :user
    association :ticket
  end
end
