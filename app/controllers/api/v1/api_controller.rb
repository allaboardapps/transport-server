class Api::V1::ApiController < ApplicationController
  protect_from_forgery prepend: true
  respond_to :json
end
