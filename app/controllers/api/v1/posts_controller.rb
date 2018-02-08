class Api::V1::PostsController < ApplicationController
  # POST /users
  swagger_controller :Posts, "Post Management"

  swagger_api :index do
    summary "Get all Posts"
    notes "Nothing else, it's that simple!"
    response :ok
  end

  def index
    render :json => {result:"Success"}, :status => 200
  end
end
