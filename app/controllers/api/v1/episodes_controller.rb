class Api::V1::EpisodesController < ApplicationController
    before_action :doorkeeper_authorize!, except: [:index,:show]
    load_and_authorize_resource
    before_action :set_episode, only: [:show, :update, :destroy]

    def index
      @episodes = Episode.order(id: :desc).page(page).per(per_page)
      render json: EpisodeSerializer.new(@episodes).serialized_json
      set_pagination_header(@episodes,"episodes")
    end
    # GET /episode/1
    # GET /episodes/1.json
    def show
      render json: EpisodeSerializer.new(@episode).serialized_json
    end
  
    # POST /episode
    # POST /episodes.json
    def create
      anime = Anime.find(params[:anime_id])
      @episode = anime.episodes.new(episode_params)
      if @episode.save
        render json: EpisodeSerializer.new(@episode).serialized_json, status: :created
      else
        render json: @episode.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /episode/1
    # PATCH/PUT /episodes/1.json
    def update
      if @episode.update(episode_params)
        render json: EpisodeSerializer.new(@episode).serialized_json, status: :ok
      else
        render json: @episode.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /episode/1
    # DELETE /episodes/1.json
    def destroy
      @episode.destroy
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_episode
        @episode = Episode.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def episode_params
        params.permit(:video)
      end
  end