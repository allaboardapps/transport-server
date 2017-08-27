require "rails_helper"

describe DirectionNames, type: :module do
  it "renders a direction name" do
    expect(described_class::EAST).to eq "east"
  end

  it "returns a list of all direction names" do
    expect(described_class.all).to include "north", "south", "east", "west"
  end
end
