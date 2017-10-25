require "rails_helper"

describe Direction, type: :model do
  it { is_expected.to belong_to :agency }

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.build(:direction)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryBot.build(:direction, name: nil)).not_to be_valid
    end
  end

  describe ".valid?" do
    it "returns false if the test_subject is blank" do
      test_subject = nil
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end

    it "returns false if the test_subject is empty" do
      test_subject = ""
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end

    it "returns true if the test_subject name matches an available instance" do
      directions = %w[north south east west]
      FactoryBot.create :direction, name: "North"
      FactoryBot.create :direction, name: "East"
      FactoryBot.create :direction, name: "South"
      FactoryBot.create :direction, name: "West"
      directions.each do |direction|
        expect(described_class.valid?(name: direction)).to be_truthy
      end
    end

    it "returns true, regardless of case" do
      directions = %w[NortH SoutH EasT WeSt]
      FactoryBot.create :direction, name: "North"
      FactoryBot.create :direction, name: "East"
      FactoryBot.create :direction, name: "South"
      FactoryBot.create :direction, name: "West"
      directions.each do |direction|
        expect(described_class.valid?(name: direction)).to be_truthy
      end
    end

    it "returns false if the test_subject name does not match an available instance" do
      FactoryBot.create :direction, name: "North"
      test_subject = "norton"
      expect(described_class.valid?(name: test_subject)).to be_falsey
    end
  end

  describe ".ci_name_search" do
    it "returns no results if a test_subject is blank" do
      FactoryBot.create :direction, name: "North"
      test_subject = nil
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end

    it "returns no results if a test_subject is empty" do
      FactoryBot.create :direction, name: "North"
      test_subject = ""
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end

    it "returns true if the test_subject name matches an available instance" do
      FactoryBot.create :direction, name: "North"
      test_subject = "north"
      expect(described_class.ci_name_search(name: test_subject)).not_to be_nil
    end

    it "returns true if the test_subject name matches an available instance, regardless of case" do
      FactoryBot.create :direction, name: "North"
      test_subject = "noRtH"
      expect(described_class.ci_name_search(name: test_subject)).not_to be_nil
    end

    it "returns false if the test_subject name does not match an available instance" do
      FactoryBot.create :direction, name: "North"
      test_subject = "norton"
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end
  end
end
