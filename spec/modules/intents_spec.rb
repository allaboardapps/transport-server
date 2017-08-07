require "rails_helper"

describe Intents, type: :module do
  it "renders an intent" do
    expect(described_class::NEXT_TRAIN).to eq "NextTrain"
  end

  it "returns a list of all intents" do
    expect(described_class.all).to include "NextTrain", "StationDirect"
  end
end
