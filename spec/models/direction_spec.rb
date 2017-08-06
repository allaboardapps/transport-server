require "rails_helper"

describe Direction, type: :model do
  it { is_expected.to belong_to :transport_system }
  it { is_expected.to have_many :stations }

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:direction)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:direction, name: nil)).not_to be_valid
    end
  end

  describe ".valid?" do
    it "returns false if the direction is blank" do
      direction = nil
      expect(Direction.valid?(name: direction)).to be_falsey
    end

    it "returns false if the direction is empty" do
      direction = ""
      expect(Direction.valid?(name: direction)).to be_falsey
    end

    it "returns true if the direction name matches an available direction" do
      directions = ["north", "south", "east", "west"]
      FactoryGirl.create :direction, name: "North"
      FactoryGirl.create :direction, name: "East"
      FactoryGirl.create :direction, name: "South"
      FactoryGirl.create :direction, name: "West"
      directions.each do |direction|
        expect(Direction.valid?(name: direction)).to be_truthy
      end
    end

    it "returns true, regardless of case" do
      directions = ["NortH", "SoutH", "EasT", "WeSt"]
      FactoryGirl.create :direction, name: "North"
      FactoryGirl.create :direction, name: "East"
      FactoryGirl.create :direction, name: "South"
      FactoryGirl.create :direction, name: "West"
      directions.each do |direction|
        expect(Direction.valid?(name: direction)).to be_truthy
      end
    end

    it "returns false if the direction name does not match an available direction" do
      FactoryGirl.create :direction, name: "North"
      direction = "norton"
      expect(Direction.valid?(name: direction)).to be_falsey
    end
  end

  describe ".ci_search" do
    it "returns no results if a direction is blank" do
      FactoryGirl.create :direction, name: "North"
      direction = nil
      expect(Direction.ci_search(name: direction)).to be_nil
    end

    it "returns no results if a direction is empty" do
      FactoryGirl.create :direction, name: "North"
      direction = ""
      expect(Direction.ci_search(name: direction)).to be_nil
    end

    it "returns true if the direction name matches an available direction" do
      FactoryGirl.create :direction, name: "North"
      direction = "north"
      expect(Direction.ci_search(name: direction)).to_not be_nil
    end

    it "returns true if the direction name matches an available direction, regardless of case" do
      FactoryGirl.create :direction, name: "North"
      direction = "noRtH"
      expect(Direction.ci_search(name: direction)).to_not be_nil
    end

    it "returns false if the direction name does not match an available direction" do
      FactoryGirl.create :direction, name: "North"
      direction = "norton"
      expect(Direction.ci_search(name: direction)).to be_nil
    end
  end
end
