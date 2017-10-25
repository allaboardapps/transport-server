require "rails_helper"

describe Stop, type: :model do
  it { is_expected.to belong_to :agency }
  it { is_expected.to belong_to :route }
  it { is_expected.to belong_to :direction }

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryBot.build(:stop)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryBot.build(:stop, name: nil)).not_to be_valid
    end
  end

  describe ".name_valid" do
    it "returns false if the stop name is blank" do
      FactoryBot.create :stop, name: "Damen"
      test_subject = nil
      expect(described_class.name_valid?(name: test_subject)).to be_falsey
    end

    it "returns false if the stop is empty" do
      FactoryBot.create :stop, name: "Western"
      test_subject = ""
      expect(described_class.name_valid?(name: test_subject)).to be_falsey
    end

    it "returns true if the stop name matches an available stop" do
      FactoryBot.create :stop, name: "Clark/Division"
      test_subject = "clark/division"
      expect(described_class.name_valid?(name: test_subject)).to be_truthy
    end

    it "returns true, regardless of case" do
      FactoryBot.create :stop, name: "Bryn Mawr"
      test_subject = "bryn mawr"
      expect(described_class.name_valid?(name: test_subject)).to be_truthy
    end

    it "returns false if the name does not match an available submission" do
      FactoryBot.create :stop, name: "Belmont"
      test_subject = "geez"
      expect(described_class.name_valid?(name: test_subject)).to be_falsey
    end
  end

  describe ".ci_name_search" do
    it "returns no results if the name is blank" do
      FactoryBot.create :stop, name: "Fullerton"
      test_subject = nil
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end

    it "returns no results if the name is empty" do
      FactoryBot.create :stop, name: "Howard"
      test_subject = ""
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end

    it "returns true if the stop name matches an available stop" do
      FactoryBot.create :stop, name: "Thorndale"
      test_subject = "thorndale"
      expect(described_class.ci_name_search(name: test_subject)).not_to be_nil
    end

    it "returns true if the stop name matches an available stop, regardless of case" do
      FactoryBot.create :stop, name: "Midway"
      test_subject = "miDWaY"
      expect(described_class.ci_name_search(name: test_subject)).not_to be_nil
    end

    it "returns false if the stop name does not match an available stop" do
      FactoryBot.create :stop, name: "O'Hare"
      test_subject = "ouch"
      expect(described_class.ci_name_search(name: test_subject)).to be_nil
    end
  end

  describe ".stop_id_valid?" do
    it "returns false if the external_id is blank" do
      FactoryBot.create :stop, name: "Damen", external_id: 1234
      test_subject = nil
      expect(described_class.stop_id_valid?(stop_id: test_subject)).to be_falsey
    end

    it "returns false if the external_id is empty" do
      FactoryBot.create :stop, name: "Western", external_id: 1234
      test_subject = ""
      expect(described_class.stop_id_valid?(stop_id: test_subject)).to be_falsey
    end

    it "returns true if the external_id matches an available stop" do
      FactoryBot.create :stop, name: "Clark/Division", external_id: 1234
      test_subject = 1234
      expect(described_class.stop_id_valid?(stop_id: test_subject)).to be_truthy
    end

    it "returns false if the external_id does not match an available submission" do
      FactoryBot.create :stop, name: "Belmont", external_id: 1234
      test_subject = 3425
      expect(described_class.stop_id_valid?(stop_id: test_subject)).to be_falsey
    end
  end
end
