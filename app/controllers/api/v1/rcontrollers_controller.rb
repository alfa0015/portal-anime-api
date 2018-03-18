class Api::V1::RcontrollersController < ApplicationController
  before_action :doorkeeper_authorize!
  load_and_authorize_resource
  before_action :set_rcontroller, only: [:show, :update, :destroy]


  # GET /rcontrollers
  # GET /rcontrollers.json
  def index
    @rcontrollers = Rcontroller.page(page).per(per_page)
    set_pagination_header(@rcontrollers,"rcontrollers")
  end

  # GET /rcontrollers/1
  # GET /rcontrollers/1.json
  def show
  end

  # POST /rcontrollers
  # POST /rcontrollers.json
  def create
    @rcontroller = Rcontroller.new(rcontroller_params)

    if @rcontroller.save
      render :show, status: :created
    else
      render json: @rcontroller.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rcontrollers/1
  # PATCH/PUT /rcontrollers/1.json
  def update
    if @rcontroller.update(rcontroller_params)
      render :show, status: :ok
    else
      render json: @rcontroller.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rcontrollers/1
  # DELETE /rcontrollers/1.json
  def destroy
    @rcontroller.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rcontroller
      @rcontroller = Rcontroller.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rcontroller_params
      params.require(:rcontroller).permit(:name,ractions_attributes: [:name])
    end
end
