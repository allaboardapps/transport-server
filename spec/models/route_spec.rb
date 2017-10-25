require "rails_helper"

describe Route, type: :model do
  it { is_expected.to belong_to :agency }
  it { is_expected.to have_many :stops }

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.build(:route)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryBot.build(:route, name: nil)).not_to be_valid
    end
  end

  describe ".valid?" do
    it "returns false if the route is blank" do
      FactoryBot.create :route, name: "Purple Line", short_name: "purple"
      test_subject = nil
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end

    it "returns false if the route is empty" do
      FactoryBot.create :route, name: "Brown Line", short_name: "brown"
      test_subject = ""
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end

    it "returns true if the route name matches an available route" do
      FactoryBot.create :route, name: "Red Line", short_name: "red"
      test_subject = "red"
      expect(described_class.valid?(name: test_subject)).to be_truthy
    end

    it "returns true, regardless of case" do
      FactoryBot.create :route, name: "Blue Line", short_name: "blue"
      test_subject = "bLuE"
      expect(described_class.valid?(name: test_subject)).to be_truthy
    end

    it "returns false if the name does not match an available submission" do
      FactoryBot.create :route, name: "Green Line", short_name: "green"
      test_subject = "geez"
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end
  end

  describe ".ci_name_search" do
    it "returns no results if the name is blank" do
      FactoryBot.create :route, name: "Purple Line", short_name: "purple"
      test_subject = nil
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end

    it "returns no results if the name is empty" do
      FactoryBot.create :route, name: "Yellow Line", short_name: "yellow"
      test_subject = ""
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end

    it "returns true if the route name matches an available route" do
      FactoryBot.create :route, name: "Brown Line", short_name: "brown"
      test_subject = "brown"
      expect(described_class.ci_name_search(name: test_subject)).not_to be_nil
    end

    it "returns true if the route name matches an available route, regardless of case" do
      FactoryBot.create :route, name: "Red Line", short_name: "red"
      test_subject = "reD"
      expect(described_class.ci_name_search(name: test_subject)).not_to be_nil
    end

    it "returns false if the route name does not match an available route" do
      FactoryBot.create :route, name: "Yellow Line", short_name: "yellow"
      test_subject = "Yow"
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end
  end
end
