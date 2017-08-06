require "rails_helper"

describe Route, type: :model do
  it { is_expected.to belong_to :transport_system }
  it { is_expected.to have_many :stations }

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:route)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:route, name: nil)).not_to be_valid
    end
  end

  describe ".valid?" do
    it "returns false if the route is blank" do
      FactoryGirl.create :route, name: "Purple"
      test_subject = nil
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end

    it "returns false if the route is empty" do
      FactoryGirl.create :route, name: "Brown"
      test_subject = ""
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end

    it "returns true if the route name matches an available route" do
      FactoryGirl.create :route, name: "Red"
      test_subject = "red"
      expect(described_class.valid?(name: test_subject)).to be_truthy
    end

    it "returns true, regardless of case" do
      FactoryGirl.create :route, name: "Blue"
      test_subject = "bLuE"
      expect(described_class.valid?(name: test_subject)).to be_truthy
    end

    it "returns false if the name does not match an available submission" do
      FactoryGirl.create :route, name: "Green"
      test_subject = "geez"
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end
  end

  describe ".ci_search" do
    it "returns no results if the name is blank" do
      FactoryGirl.create :route, name: "North"
      test_subject = nil
      expect(described_class.ci_search(name: test_subject)).to be_nil
    end

    it "returns no results if the name is empty" do
      FactoryGirl.create :route, name: "North"
      test_subject = ""
      expect(described_class.ci_search(name: test_subject)).to be_nil
    end

    it "returns true if the route name matches an available route" do
      FactoryGirl.create :route, name: "Brown"
      test_subject = "brown"
      expect(described_class.ci_search(name: test_subject)).not_to be_nil
    end

    it "returns true if the route name matches an available route, regardless of case" do
      FactoryGirl.create :route, name: "Red"
      test_subject = "reD"
      expect(described_class.ci_search(name: test_subject)).not_to be_nil
    end

    it "returns false if the route name does not match an available route" do
      FactoryGirl.create :route, name: "Yellow"
      test_subject = "Yow"
      expect(described_class.ci_search(name: test_subject)).to be_nil
    end
  end
end
