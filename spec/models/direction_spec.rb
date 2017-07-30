require "rails_helper"

describe Direction, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:direction)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:direction, name: nil)).not_to be_valid
    end
  end
end
