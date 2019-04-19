class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {errors: exception }, status: :not_found
  end

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

  #Method set page pagination
  def page
    @page ||= params[:page] || 1
  end

  #Method set number record per page
  def per_page
    @per_page ||= params[:per_page] || 25
  end

  #Method set headers pagination
  def set_pagination_header(resource,resource_name)
    #print current page
    headers["x-page"] = page
    #print records per page
    headers["x-per-page"] = per_page
    #print total records
    headers["x-total"] = resource.total_count
    #print total pages
    headers["x-page-total"] = (resource.total_count.to_f / per_page.to_f).ceil
    #print next page url
    headers["next_page"] = eval "api_v1_#{resource_name}_url(request.query_parameters.merge(page: resource.next_page))" if resource.next_page
    #print prev page url
    headers["prev_page"] = eval "api_v1_#{resource_name}_url(request.query_parameters.merge(page: resource.next_page))" if resource.prev_page
  end
  
end
