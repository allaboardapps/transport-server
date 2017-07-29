require "rails_helper"

describe RequestHandler, type: :service do
  describe ".process" do
    it "coverts request into hash" do
      processed_request = described_class.process(40380)
      expect(processed_request[:line]).to eq "brown"
      expect(processed_request[:direction]).to eq "north"
    end
  end
end
