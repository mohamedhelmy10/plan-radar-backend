require 'rails_helper'

RSpec.describe Ticket, type: :model do
  # Associations
  it { should belong_to(:assigned_user) }
  it { should belong_to(:status) }

  # Validations
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:assigned_user_id) }
  it { should validate_presence_of(:status_id) }
  it { should validate_presence_of(:due_date) }

  describe "validations" do
    let!(:status) { Status.find_or_create_by(name: :pending) }
    let!(:user) { create(:user) }

    it "validates progress is between 0 and 100" do
      ticket = build(:ticket, progress: 150, assigned_user: user, status: status)
      expect(ticket).to_not be_valid
      expect(ticket.errors[:progress]).to include("must be an integer between 0 and 100")

      ticket.progress = 50
      expect(ticket).to be_valid
    end

    it "validates due date is not in the past" do
      ticket = build(:ticket, due_date: 1.day.ago, assigned_user: user, status: status)
      expect(ticket).to_not be_valid
      expect(ticket.errors[:due_date]).to include("can't be in the past")

      ticket.due_date = 1.week.from_now
      expect(ticket).to be_valid
    end
  end
end
