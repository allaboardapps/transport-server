require "rails_helper"

describe Station, type: :model do
  it { is_expected.to belong_to :agency }
  it { is_expected.to belong_to :direction }
  it { is_expected.to belong_to :route }

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:station)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:station, name: nil)).not_to be_valid
    end
  end

  describe ".valid?" do
    it "returns false if the station is blank" do
      FactoryGirl.create :station, name: "Damen"
      test_subject = nil
      expect(described_class.name_valid?(name: test_subject)).to be_falsey
    end

    it "returns false if the station is empty" do
      FactoryGirl.create :station, name: "Western"
      test_subject = ""
      expect(described_class.name_valid?(name: test_subject)).to be_falsey
    end

    it "returns true if the station name matches an available station" do
      FactoryGirl.create :station, name: "Clark/Division"
      test_subject = "clark/division"
      expect(described_class.name_valid?(name: test_subject)).to be_truthy
    end

    it "returns true, regardless of case" do
      FactoryGirl.create :station, name: "Bryn Mawr"
      test_subject = "bryn mawr"
      expect(described_class.name_valid?(name: test_subject)).to be_truthy
    end

    it "returns false if the name does not match an available submission" do
      FactoryGirl.create :station, name: "Belmont"
      test_subject = "geez"
      expect(described_class.name_valid?(name: test_subject)).to be_falsey
    end
  end

  describe ".ci_search" do
    it "returns no results if the name is blank" do
      FactoryGirl.create :station, name: "Fullerton"
      test_subject = nil
      expect(described_class.ci_search(name: test_subject)).to be_nil
    end

    it "returns no results if the name is empty" do
      FactoryGirl.create :station, name: "Howard"
      test_subject = ""
      expect(described_class.ci_search(name: test_subject)).to be_nil
    end

    it "returns true if the station name matches an available station" do
      FactoryGirl.create :station, name: "Thorndale"
      test_subject = "thorndale"
      expect(described_class.ci_search(name: test_subject)).not_to be_nil
    end

    it "returns true if the station name matches an available station, regardless of case" do
      FactoryGirl.create :station, name: "Midway"
      test_subject = "miDWaY"
      expect(described_class.ci_search(name: test_subject)).not_to be_nil
    end

    it "returns false if the station name does not match an available station" do
      FactoryGirl.create :station, name: "O'Hare"
      test_subject = "ouch"
      expect(described_class.ci_search(name: test_subject)).to be_nil
    end
  end

  describe ".stopid_valid?" do
    it "returns false if the stopid is blank" do
      FactoryGirl.create :station, name: "Damen", stopid: 1234
      test_subject = nil
      expect(described_class.stopid_valid?(stopid: test_subject)).to be_falsey
    end

    it "returns false if the stopid is empty" do
      FactoryGirl.create :station, name: "Western", stopid: 1234
      test_subject = ""
      expect(described_class.stopid_valid?(stopid: test_subject)).to be_falsey
    end

    it "returns true if the stopid matches an available station" do
      FactoryGirl.create :station, name: "Clark/Division", stopid: 1234
      test_subject = 1234
      expect(described_class.stopid_valid?(stopid: test_subject)).to be_truthy
    end

    it "returns false if the stopid does not match an available submission" do
      FactoryGirl.create :station, name: "Belmont", stopid: 1234
      test_subject = 3425
      expect(described_class.stopid_valid?(stopid: test_subject)).to be_falsey
    end
  end
end
