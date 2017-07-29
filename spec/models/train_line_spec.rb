require "rails_helper"

describe TrainLine, type: :model do
  describe ".seed" do
    it "creates an instance" do
      described_class.seed(name: "Brown")
      expect(described_class.where(seed: true).count).to eq(1)
    end
  end
end
