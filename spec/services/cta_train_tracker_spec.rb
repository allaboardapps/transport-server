require "rails_helper"

describe CtaTrainTracker, type: :service do
  describe ".request" do
    xit "returns a response in xml format" do
      response = described_class.request(40380)
      expect(response).to eq "test"
    end
  end
end
