require 'rails_helper'

RSpec.describe User, type: :model do
  # Associations
  it { should have_many(:notifications) }
  it { should have_many(:tickets).with_foreign_key(:assigned_user_id) }

  # Validations
  describe "validations" do
    let(:user) { build(:user) }

    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is not valid without a name" do
      user.name = nil
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is not valid without an email" do
      user.email = nil
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "is not valid with an invalid email format" do
      user.email = "invalid_email"
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("is not a valid email")
    end

    it "is not valid with a non-unique email" do
      create(:user, email: "test@example.com")
      user.email = "test@example.com"
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is not valid without a time_zone" do
      user.time_zone = nil
      expect(user).not_to be_valid
      expect(user.errors[:time_zone]).to include("can't be blank")
    end

    it "is not valid with an invalid time_zone" do
      user.time_zone = "Invalid/TimeZone"
      expect(user).not_to be_valid
      expect(user.errors[:time_zone]).to include("is not a valid time zone")
    end

    it "is valid with a valid time_zone" do
      user.time_zone = "Europe/Vienna"
      expect(user).to be_valid
    end
  end
end
