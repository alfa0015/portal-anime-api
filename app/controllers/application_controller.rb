class ApplicationController < ActionController::API
  #Return error when is 401 
  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { error: "Not authorized" } }
  end

end
