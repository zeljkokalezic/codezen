class V1::BaseController < ActionController::API
  include Response
  include Knock::Authenticable

  before_action :authenticate_user
end
