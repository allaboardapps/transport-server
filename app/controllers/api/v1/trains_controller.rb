module Api
  module V1
    class TrainsController < Api::V1::ApiController
      def index
        Rails.logger.info "[PARAMS]: #{request.params.inspect}"
        render json: { data: { test: "something" } }, status: :ok
      end
    end
  end
end
