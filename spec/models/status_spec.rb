require 'rails_helper'

RSpec.describe Status, type: :model do
  # Associations
  it { should have_many(:tickets) }

  # Validations
  it { should validate_presence_of(:name) }

  # Create statuses before running enum tests
  before(:all) do
    Status.create(name: :pending)
    Status.create(name: :in_progress)
    Status.create(name: :completed)
    Status.create(name: :on_hold)
    Status.create(name: :resolved)
    Status.create(name: :over_due)
  end

  describe "enum name" do
    it "maps pending to 0" do
      expect(Status.find_by(name: 0).name).to eq('pending')
    end
    it "maps in_progress to 1" do
			expect(Status.find_by(name: 1).name).to eq('in_progress')
    end
    it "maps completed to 2" do
			expect(Status.find_by(name: 2).name).to eq('completed')
    end
    it "maps on_hold to 3" do
      expect(Status.find_by(name: 3).name).to eq('on_hold')
    end
    it "maps resolved to 4" do
      expect(Status.find_by(name: 4).name).to eq('resolved')
    end
    it "maps overdue to 5" do
      expect(Status.find_by(name: 5).name).to eq('over_due')
    end
  end
end
