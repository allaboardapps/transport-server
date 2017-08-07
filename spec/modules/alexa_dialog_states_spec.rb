require "rails_helper"

describe AlexaDialogStates, type: :module do
  it "renders a state" do
    expect(described_class::STARTED).to eq "started"
  end

  it "returns a list of all states" do
    expect(described_class.all).to include "started", "in_progress", "completed"
  end
end
