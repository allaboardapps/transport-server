module Api
  module V1
    class TrainsController < Api::V1::ApiController
      def index
        Rails.logger.info "[PARAMS]: #{request.params.inspect}"
        render file: "api/v1/trains/index.json.erb", content_type: "application/json"
      end
    end
  end
end
