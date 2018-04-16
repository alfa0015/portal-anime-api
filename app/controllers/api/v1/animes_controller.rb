class Api::V1::AnimesController < ApplicationController
  before_action :doorkeeper_authorize!, except: [:index,:show]
  load_and_authorize_resource
  before_action :set_anime, only: [:show, :update, :destroy]
  before_action :set_anime_tag, only: [:add_tags]


  # GET /animes
  # GET /animes.json
  def index
    @animes = Anime.page(page).per(per_page)
    set_pagination_header(@animes,"animes")
  end

  # GET /animes/1
  # GET /animes/1.json
  def show
  end

  # POST /animes
  # POST /animes.json
  def create
    tags = params["tags"].each{|k,v| v}
    tags = tags.map{|k,v| v}
    params["tags"] = tags
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

  def tags
  end

  def add_tags
    binding.pry
    new_tag = tags_params["tags"]
    @anime.tags_will_change!
    @anime.tags.push(new_tag)
    @anime.save
    render :tags, status: :create
  end

  def delete_tags
    @anime.tags_will_change!
    @anime.tags = @anime.tags.select{|tag| tag["name"] != tags_params["tags"]["name"]}
    if @anime.save
      render json:{},status: :no_content
    else
      render json:{errors: @animes.errors.full_messages},status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_anime
      @anime = Anime.find(params[:id])
    end

    def set_anime_tag
      @anime = Anime.find(params[:anime_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def anime_params
      params.permit(:name, :synopsis, :sessions, :episodes,:cover,:tags => [:name])
    end

    def tags_params
      params.require(:anime).permit(:tags => [:name])
    end
end
