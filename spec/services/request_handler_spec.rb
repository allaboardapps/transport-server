require "rails_helper"

describe RequestHandler, type: :service do
  describe ".process" do
    it "coverts request into hash" do
      request = { direction: "fee", route: "fi", station: "fo" }
      processed_request = described_class.process(request)
      expect(processed_request[:direction]).to eq request[:direction]
      expect(processed_request[:route]).to eq request[:route]
      expect(processed_request[:station]).to eq request[:station]
    end
  end
end
