class Api::V1::TvshowsController < ApplicationController
  before_action :set_tvshow, only: [:show, :update, :destroy]

  # GET /tvshows
  # GET /tvshows.json
  def index
    @tvshows = Tvshow.page(page).per(per_page)
    set_pagination_headers
  end

  # GET /tvshows/1
  # GET /tvshows/1.json
  def show
  end

  # POST /tvshows
  # POST /tvshows.json
  def create
    @tvshow = Tvshow.new(tvshow_params)

    if @tvshow.save
      render :show, status: :created, location: @tvshow
    else
      render json: @tvshow.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tvshows/1
  # PATCH/PUT /tvshows/1.json
  def update
    if @tvshow.update(tvshow_params)
      render :show, status: :ok, location: @tvshow
    else
      render json: @tvshow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tvshows/1
  # DELETE /tvshows/1.json
  def destroy
    @tvshow.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tvshow
      @tvshow = Tvshow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tvshow_params
      params.require(:tvshow).permit(:name)
    end

    def page
      @page = params[:page] || 1
    end

    def per_page
      @per_page = params[:per_page] || 10
    end

    def set_pagination_headers
      headers["X-Total-Count"] = @tvshows.total_count
      headers["Link"] = page_link(@tvshows.next_page,"next") if @tvshows.next_page
    end

    def page_link(page, rel)
      "<#{api_v1_tvshows_url(request.query_parameters.merge(page:@tvshows.next_page))}>; rel='#{rel}'"
    end
end
