require "rails_helper"

describe Api::V1::TrainsController, type: :controller do
  render_views

  describe "#alexa" do
    let(:payload) { JSON.parse(File.read(Rails.root.join("spec", "fixtures", "alexa_request.json"))) }

    it "returns a response with the proper keys" do
      payload["request"]["intent"]["name"] = Intents::STOP_DIRECT
      payload["request"]["intent"]["slots"]["stop_id"]["value"] = 30126
      payload["request"]["intent"]["slots"]["direction"]["value"] = "north"

      request.env["CONTENT_TYPE"] = "application/json"
      request.env["RAW_POST_DATA"] = payload.to_json
      post :alexa

      expect_json_keys([:version, :response, :shouldEndSession])
      expect_json_keys("response", [:outputSpeech])
      expect_json_keys("response.outputSpeech", [:type, :ssml])
    end

    xit "returns a response with the proper data types" do
      post :alexa
      expect_json_types(version: :string, response: :object, shouldEndSession: :boolean)
      expect_json_types("response", outputSpeech: :object)
      expect_json_types("response.outputSpeech", type: :string, ssml: :string)
    end

    xit "returns a status of 200" do
      post :alexa
      expect_status :ok
    end
  end
end
