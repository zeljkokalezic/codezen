class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception

  def set_api_auth_token
    @api_token = current_user.present? ? Knock::AuthToken.new(payload: { sub: current_user.id }).token : nil
  end
end
