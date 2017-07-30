require "rails_helper"

describe StationTypes, type: :module do
  it "renders a route type" do
    expect(described_class::TRAIN).to eq "train"
  end

  it "returns a list of all route types" do
    expect(described_class.all).to include "bus", "train"
  end
end
