require "rails_helper"

describe ResponseHandler, type: :service do
  describe ".process" do
    it "returns speech text for response" do
      processed_response = { direction: "fe", route: "fi", station: "fo" }
      response = described_class.process(processed_response)
      # rubocop:disable Metrics/LineLength
      # expect(response).to eq "<speak><p>The next northbound brown line train should arrive at the <phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme> station in 1 minute.</p><p>A following northbound brown line train should arrive at the <phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme> station in 13 minutes.</p><p>A third northbound brown line train should arrive at the <phoneme alphabet='ipa' ph='dɛmen'>Damen</phoneme> station in 22 minutes.</p></speak>"
      expect(response).to eq(
        "<speak>"\
          "<p>direction #{processed_response[:direction]}</p>"\
          "<p>route #{processed_response[:route]}</p>"\
          "<p>station #{processed_response[:station]}</p>"\
        "</speak>"
      )
      # rubocop:enable Metrics/LineLength
    end
  end
end
