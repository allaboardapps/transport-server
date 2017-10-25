require "rails_helper"

describe Slots, type: :module do
  it "renders a slot" do
    expect(described_class::DIRECTION).to eq "direction"
  end

  it "returns a list of all slots" do
    expect(described_class.all).to include "direction", "route", "stop"
  end
end
