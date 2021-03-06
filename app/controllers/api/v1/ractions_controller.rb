class Api::V1::RactionsController < ApplicationController
  before_action :doorkeeper_authorize!
  load_and_authorize_resource
  before_action :set_controller
  before_action :set_raction, only: [:show, :update, :destroy]

  # GET /ractions
  # GET /ractions.json
  def index
    @ractions = Raction.page(page).per(per_page)
    set_pagination_header(@ractions,"rcontroller_ractions")
  end

  # GET /ractions/1
  # GET /ractions/1.json
  def show
  end

  # POST /ractions
  # POST /ractions.json
  def create
    @raction = @rcontroller.ractions.new(raction_params)
    if @raction.save
      render :show, status: :created
    else
      render json: @raction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ractions/1
  # PATCH/PUT /ractions/1.json
  def update
    if @raction.update(raction_params)
      render :show, status: :ok
    else
      render json: @raction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ractions/1
  # DELETE /ractions/1.json
  def destroy
    @raction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_raction
      @raction = Raction.find(params[:id])
    end

    def set_controller
      @rcontroller = Rcontroller.find(params[:rcontroller_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def raction_params
      params.require(:raction).permit(:name, :rcontroller_id)
    end
end
