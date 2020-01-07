class MachineHistoriesController < ApplicationController
  before_action :set_machine_history, only: [:show, :edit, :update, :destroy]

  # GET /machine_histories
  # GET /machine_histories.json
  def index
    @machine_histories = MachineHistory.all
  end

  # GET /machine_histories/1
  # GET /machine_histories/1.json
  def show
  end

  # GET /machine_histories/new
  def new
    @machine_history = MachineHistory.new
  end

  # GET /machine_histories/1/edit
  def edit
  end

  # POST /machine_histories
  # POST /machine_histories.json
  def create
    @machine_history = MachineHistory.new(machine_history_params)
    respond_to do |format|
      if @machine_history.save
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('machine_add_success') }
        format.json { render :show, status: :created, location: @machine_history }
      else
        format.html { render :new }
        format.json { render json: @machine_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machine_histories/1
  # PATCH/PUT /machine_histories/1.json
  def update
    respond_to do |format|
      if @machine_history.update(machine_history_params)
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('machine_update_success')}
        format.json { render :show, status: :ok, location: @machine_history }
      else
        format.html { render :edit }
        format.json { render json: @machine_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machine_histories/1
  # DELETE /machine_histories/1.json
  def destroy
    @machine_history.destroy
    respond_to do |format|
      format.html {redirect_to request.env["HTTP_REFERER"], notice: t('machine_detroy_success')}
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_machine_history
    @machine_history = MachineHistory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def machine_history_params
    params.require(:machine_history).permit(:date, :amount, :machine_id)
  end
end
