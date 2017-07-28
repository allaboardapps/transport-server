module Api
  module V1
    class ApiController < ApplicationController
      protect_from_forgery prepend: true
      respond_to :json
    end
  end
end
