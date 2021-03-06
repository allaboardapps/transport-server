module Api
  module V1
    class TrainsController < Api::V1::ApiController
      def alexa
        logger.info(params.to_json)

        payload = RequestHandler.process(params)
        @payload = ResponseHandler.process(payload)

        response_body = render_to_string(
          file: "api/v1/trains/alexa_#{@payload[:response][:template]}.json.erb",
          content_type: "application/json"
        )

        session_log = SessionLog.find_by(id: payload[:session_log_id])
        session_log.update(
          response_body: response_body
        )

        render(
          file: "api/v1/trains/alexa_#{@payload[:response][:template]}.json.erb",
          content_type: "application/json"
        )
      end
    end
  end
end
