require "rails_helper"

describe RouteNames, type: :module do
  it "renders a route name" do
    expect(described_class::BROWN).to eq "brown"
  end

  it "returns a list of all route names" do
    expect(described_class.all).to include "brown", "pink", "yellow"
  end
end
