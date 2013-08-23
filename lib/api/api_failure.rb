class Api::ApiFailure < Devise::FailureApp
  include ActionController::Rendering
  def respond
    if request_format == :json
      puts 'okay json'
      render 'app/views/api/api_failure/respond', status: 200
    else
      super
    end
  end
end