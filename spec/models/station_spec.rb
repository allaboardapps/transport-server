require "rails_helper"

describe Station, type: :model do
  it { is_expected.to belong_to :transport_system }
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
end
