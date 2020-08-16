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

  def machine_list
    @machine =  Machine.find(params[:machine])
    @projects = @machine.projects
    @wares = Ware.where(project_id: @projects).where(machine_specific: true)
    @model = params[:ware_model]
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
    @project = @ware.project
    @wares = @project&.wares
    respond_to do |format|
      if @ware.save
        # update linked project
        @ware.project&.update_totals_project(@ware.project)
        # update linked project's invoice
        @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects)
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
    @project = @ware.project
    @wares = @project&.wares
    respond_to do |format|
      if @ware.update(ware_params)
        # update linked project
        @ware.project&.update_totals_project(@ware.project)

        # update linked project's invoice
        @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects)
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
    @project = @ware.project
    @wares = @project&.wares

    @ware.destroy
    # update linked project
    @ware.project&.update_totals_project(@ware.project)

    # update linked project's invoice
    @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects)
    respond_to do |format|
      format.html { redirect_to request.env["HTTP_REFERER"], notice: t('ware_destroy_success') }
      format.js
    end
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
                                 :provider_name, :provider_discount, :sell_price,
                                 :provider_invoice, :ware_name, :show_desc_quot,
                                 :show_desc_invoice, :machine_specific,
                                 :is_maintenance, :machine_id)
  end

end
