require "rails_helper"

describe Api::V1::TrainsController, type: :controller do
  render_views

  describe "#alexa" do
    xit "returns a response with the proper keys" do
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
