require "rails_helper"

describe Station, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:station)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:station, name: nil)).not_to be_valid
    end
  end

  describe ".seed" do
    it "creates an instance" do
      described_class.seed(name: "Damen")
      expect(described_class.where(seed: true).count).to eq(1)
    end
  end
end
