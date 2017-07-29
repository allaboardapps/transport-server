module Api
  module V1
    class TrainsController < Api::V1::ApiController
      def index
        processed_request = RequestHandler.process(request)
        @processed_response = ResponseHandler.process(processed_request)

        render file: "api/v1/trains/index.json.erb", content_type: "application/json"
      end
    end
  end
end
