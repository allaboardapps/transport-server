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
end
