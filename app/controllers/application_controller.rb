class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      verified_token = JWT.decode(
        token, 
        JWT_SECRET,
        true,
        { algorithm: 'HS512' }
      )
      
      user_id = verified_token.first['user_id']
      @current_user = User.find(user_id)
    end
    rescue
      render status: :unauthorized
  end
end
