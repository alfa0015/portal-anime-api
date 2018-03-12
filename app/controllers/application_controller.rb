class ApplicationController < ActionController::API
  #Return error when is 401
  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { errors: "Not authorized" } }
  end

end
