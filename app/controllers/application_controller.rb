class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActionController::ParameterMissing do |exception|
    render json: {errors:"#{exception.param} is required"}, status: 422
  end
  include CanCan::ControllerAdditions

  #Return error when is 401
  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { errors: "Not authorized" } }
  end

  rescue_from CanCan::AccessDenied do |exception|
    render json: {errors: "Not authorized" }, status: :unauthorized
  end

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def record_not_found
    render json: {errors:"Record not found"} # Assuming you have a template named 'record_not_found'
  end

end
