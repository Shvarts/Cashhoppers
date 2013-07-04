class Api::ApplicationController < ApplicationController
  # we dont need forgery protection on api calls
  skip_before_filter :verify_authenticity_token
  before_filter :check_api_key
end
