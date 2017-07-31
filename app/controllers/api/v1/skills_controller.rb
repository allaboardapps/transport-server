module Api
  module V1
    class SkillsController < Api::V1::ApiController
      def show
        processed_request = RequestHandler.process(request)
        @processed_response = ResponseHandler.process(processed_request)

        render file: "api/v1/skills/show.json.erb", content_type: "application/json"
      end
    end
  end
end
