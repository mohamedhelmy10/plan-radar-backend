require 'rails_helper'

RSpec.describe Status, type: :model do
  # Associations
  it { should have_many(:tickets) }

  # Validations
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_inclusion_of(:name).in_array(['Pending', 'In Progress', 'Completed', 'On Hold', 'Resolved', 'Over Due']) }

  # Enum validation for notification type
  describe "enums" do
    it "should define valid notification types" do
      expect(Status.notification_types.keys).to match_array(['email', 'sms', 'push'])
    end
  end

  # Optional: You can also add tests for default status and any scopes (if defined in the model)

  # Example: Test default status method
  describe ".default_status" do
    it "returns the default status 'Pending'" do
      default_status = Status.default_status
      expect(default_status.name).to eq('Pending')
    end
  end

  # Optional: Test scopes if defined
  describe ".active" do
    it "returns the active statuses" do
      active_statuses = Status.active
      expect(active_statuses).to include(Status.find_by(name: 'Pending'))
      expect(active_statuses).to include(Status.find_by(name: 'In Progress'))
      expect(active_statuses).to include(Status.find_by(name: 'On Hold'))
    end
  end
end
