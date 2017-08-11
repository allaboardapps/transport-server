require "rails_helper"

describe RouteTypes, type: :module do
  it "renders a route type" do
    expect(described_class::BUS).to eq "bus"
  end

  it "returns a list of all route types" do
    expect(described_class.all).to include "bus", "train"
  end
end
