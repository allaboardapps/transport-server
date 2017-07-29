require "rails_helper"

describe ResponseHandler, type: :service do
  describe ".process" do
    it "returns speech text for response" do
      processed_response = RequestHandler.process("test")
      response = described_class.process(processed_response)
      # rubocop:disable Metrics/LineLength
      expect(response).to eq "<speak><p>The next northbound brown line train should arrive at the <phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme> station in 1 minute.</p><p>The next northbound brown line train should arrive at the <phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme> station in 13 minutes.</p><p>The next northbound brown line train should arrive at the <phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme> station in 22 minutes.</p></speak>"
      # rubocop:enable Metrics/LineLength
    end
  end
end
