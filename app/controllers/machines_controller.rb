class MachinesController < ApplicationController
  before_action :set_machine, only: [:show, :edit, :update, :destroy]

  # GET /machines
  # GET /machines.json
  def index
    @search = Machine.order(brand: :desc).ransack(params[:q])
    @machines = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
    @search_projects = Project.where(machine_id: params[:id]).ransack(params[:q])
    @projects = @search_projects.result.paginate(page: params[:page], per_page: 10)

    @machine_history = MachineHistory.order(date: :asc).where(machine_id: params[:id])
    @maintenance_wares = Ware.where(machine_id: params[:id]).where(is_maintenance: true)

    @search_wares = Ware.where(project_id: @projects.ids).where(machine_specific: true).ransack(params[:q])
    @wares = @search_wares.result.paginate(page: params[:page], per_page: 10)
  end

  # GET /machines/new
  def new
    @machine = Machine.new
  end

  # GET /machines/1/edit
  def edit
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(machine_params)

    respond_to do |format|
      if @machine.save
        format.html {redirect_to @machine, notice: t('machine_add_success')}
        format.json { render :show, status: :created, location: @machine }
      else
        format.html { render :new }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('machine_update_success')}
        format.json { render :show, status: :ok, location: @machine }
      else
        format.html { render :edit }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    @machine.destroy
    respond_to do |format|
      format.html {redirect_to request.env["HTTP_REFERER"], notice: t('machine_detroy_success')}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:model, :brand, :year, :category, :comment, :oils_text,:customer_id, :isKm)
    end
end
