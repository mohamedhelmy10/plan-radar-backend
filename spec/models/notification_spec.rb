require 'rails_helper'

RSpec.describe Notification, type: :model do
  # Assuming you have factories for user and ticket
  let(:user) { create(:user) }
  let(:ticket) { create(:ticket) }

  # Test associations
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:ticket) }
  end

  # Test validations
  describe 'validations' do
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:sent_at) }
    it { should validate_presence_of(:notification_type) }
  end

  # Test Enum for notification_type
  describe 'enum notification_type' do
    it 'defines the notification types' do
      expect(Notification.notification_types).to eq({ "email" => 0 })
    end

    it 'can be assigned email' do
      notification = build(:notification, notification_type: :email)
      expect(notification.email?).to be_truthy
    end
  end

  # Test factory
  describe 'factory' do
    it 'has a valid factory' do
      notification = build(:notification, user: user, ticket: ticket)
      expect(notification).to be_valid
    end
  end
end
