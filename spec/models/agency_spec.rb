require "rails_helper"

describe Agency, type: :model do
  it { is_expected.to have_many :routes }
  it { is_expected.to have_many :directions }
  it { is_expected.to have_many :stops }
  it { is_expected.to have_many :stations }

  describe "validations" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:agency)).to be_valid
    end

    it "is invalid without a name" do
      expect(FactoryGirl.build(:agency, name: nil)).not_to be_valid
    end
  end
end
