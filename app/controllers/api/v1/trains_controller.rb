module Api
  module V1
    class TrainsController < Api::V1::ApiController
      def alexa
        processed_request = RequestHandler.process(params[:request])
        @processed_response = ResponseHandler.process(processed_request)

        render file: "api/v1/trains/alexa_#{@processed_response[:state]}.json.erb", content_type: "application/json"
      end
    end
  end
end
