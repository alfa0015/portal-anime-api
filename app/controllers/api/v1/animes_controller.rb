class Api::V1::AnimesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index,:show]
  load_and_authorize_resource
  before_action :set_anime, only: [:show, :update, :destroy]


  # GET /animes
  # GET /animes.json
  def index
    @animes = Anime.all
  end

  # GET /animes/1
  # GET /animes/1.json
  def show
  end

  # POST /animes
  # POST /animes.json
  def create
    @anime = Anime.new(anime_params)

    if @anime.save
      render :show, status: :created
    else
      render json: @anime.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /animes/1
  # PATCH/PUT /animes/1.json
  def update
    if @anime.update(anime_params)
      render :show, status: :ok
    else
      render json: @anime.errors, status: :unprocessable_entity
    end
  end

  # DELETE /animes/1
  # DELETE /animes/1.json
  def destroy
    @anime.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anime
      @anime = Anime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anime_params
      params.require(:anime).permit(:name, :synopsis, :sessions, :episodes)
    end
end
