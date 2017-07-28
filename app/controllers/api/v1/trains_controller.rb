module Api
  module V1
    class TrainsController < Api::V1::ApiController
      def index
        Rails.logger.info "[PARAMS]: #{request.params.inspect}"

        response_body = {
          version: "1.0",
          response: {
            outputSpeech: {
              type: "SSML",
              ssml: "<speak>The next Southbound Brown Line Train should arrive at the <phoneme alphabet='ipa' ph='dɛmen'>Damen station in 11 minutes</speak>"
            }
          },
          shouldEndSession: true
        }

        render json: response_body, status: :ok
      end
    end
  end
end
