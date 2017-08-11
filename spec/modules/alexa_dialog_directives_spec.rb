require "rails_helper"

describe AlexaDialogDirectives, type: :module do
  it "renders a step" do
    expect(described_class::CONFIRM_SLOT).to eq "Dialog.ConfirmSlot"
  end

  it "returns a list of all steps" do
    expect(described_class.all).to include "Dialog.Delegate", "Dialog.ElicitSlot", "Dialog.ConfirmSlot", "Dialog.ConfirmIntent"
  end
end
