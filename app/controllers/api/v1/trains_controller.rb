module Api
  module V1
    class TrainsController < Api::V1::ApiController
      def alexa
        logger.info(params.to_json)

        conn = RequestHandler.process(params)
        @conn = ResponseHandler.process(conn)

        render(
          file: "api/v1/trains/alexa_#{@conn[:response][:template]}.json.erb",
          content_type: "application/json"
        )
      end
    end
  end
end
