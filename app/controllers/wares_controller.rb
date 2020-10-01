class WaresController < ApplicationController
  before_action :set_ware, only: %i[show edit update destroy]
  load_and_authorize_resource
  # GET /wares
  # GET /wares.json
  def index
    @search = Ware.order(id: :desc).includes(:customer).includes(:project).ransack(params[:q])
    @wares = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /wares/1
  # GET /wares/1.json
  def show;
  end

  def specific_list
    @machine =  Machine.find(params[:machine])
    @projects = @machine.projects
    @specific_wares = Ware.where(project_id: @projects).where(machine_specific: true)
  end

  def maintenance_list
    @machine =  Machine.find(params[:machine])
    @maintenance_wares = Ware.where(machine_id: @machine.id).where(is_maintenance: true)
  end

  def list
    @wares = Ware.where(project_id: params[:project])
    @project =  Project.find(params[:project])
  end

  def sort
    params[:ware].each_with_index do |id, index|
      Ware.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  # GET /wares/new
  def new
    @ware = Ware.new
    respond_to(&:js)
  end

  # GET /wares/1/edit
  def edit;
  end

  # POST /wares
  # POST /wares.json
  def create
    @ware = Ware.new(ware_params)
    respond_to do |format|
      if @ware.save
        if params[:ware][:is_maintenance] || params[:ware][:machine_specific] == true
          get_machine_data(params[:ware][:machine_id])
        else
          get_project_data
        end
        @project&.update_totals_project(@ware.project) # update linked project
        @project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects) # update linked project's invoice
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('ware_add_success') }
        format.js
      else
        format.html { render :new }
        format.json { render json: @ware.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wares/1
  # PATCH/PUT /wares/1.json
  def update
    respond_to do |format|
      if @ware.update(ware_params)
        if params[:ware][:is_maintenance] || params[:ware][:machine_specific] == true
          get_machine_data(params[:ware][:machine_id])
        else
          get_project_data
        end
        @ware.project&.update_totals_project(@ware.project) # update linked project
        @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects) # update linked project's invoice
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('ware_update_success') }
        format.js
        format.json { render :show, status: :ok, location: @ware }
      else
        format.html { render :edit }
        format.json { render json: @ware.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wares/1
  # DELETE /wares/1.json
  def destroy
    @ware.destroy
    respond_to do |format|
      if params[:is_maintenance] || params[:machine_specific] == true
        get_machine_data(params[:machine])
      else
        get_project_data
      end
      @ware.project&.update_totals_project(@ware.project) # update linked project
      @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects) # update linked project's invoice
      format.html { redirect_to request.env["HTTP_REFERER"], notice: t('ware_destroy_success') }
      format.js
    end
  end

  def get_machine_data(id)
    @machine = Machine.find(id)
    @maintenance_wares = Ware.where(machine_id: @machine.id).where(is_maintenance: true)
    @projects = Project.where(machine_id: id)
    @specific_wares = Ware.where(project_id: @projects.ids).where(machine_specific: true)
  end

  def get_project_data
    @project = @ware.project
    @machine = @project&.machine
    @wares = @project&.wares
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ware
    @ware = Ware.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ware_params
    params.require(:ware).permit(:project_id, :invoice_id, :customer_id,
                                 :quotation_id, :name, :comment, :quantity,
                                 :margin, :provider_price, :bought_price,
                                 :status, :tva_rate, :total_cost, :total_gross,
                                 :provider_discount, :sell_price, :is_maintenance,
                                 :ware_name, :show_desc_quot, :machine_id,
                                 :show_desc_invoice, :machine_specific,
                                 :reference_1, :reference_2, :reference_3,
                                 :provider_1, :provider_2, :provider_3)
  end

end