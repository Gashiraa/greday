class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /services
  # GET /services.json
  def index
    @search = Service.order(date: :desc).includes(:project).ransack(params[:q])
    @services = @search.result.paginate(page: params[:page], per_page: 30)
  end

  # GET /services/1
  # GET /services/1.json
  def show
  end

  def list
    @services = Service.where(project_id: params[:project])
    @project =  Project.find(params[:project])
  end

  def sort
    params[:service].each_with_index do |id, index|
      Service.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  # GET /services/new
  def new
    @service = Service.new
    respond_to(&:js)
  end

  # GET /services/1/edit
  def edit
  end

  # POST /services
  # POST /services.json
  def create
    @service = Service.new(service_params)
    @project = @service.project
    @services = @project.services
    respond_to do |format|
      if @service.save
        @service.project&.update_totals_project(@project)
        @service.project&.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects)
        format.js
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('service_add_success') }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /services/1
  # PATCH/PUT /services/1.json
  def update
    @project = @service.project
    @services = @project.services
    respond_to do |format|
      if @service.update(service_params)
        @service.project&.update_totals_project(@project)
        @service.project&.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects)
        format.js
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('service_update_success') }
        format.json { render :show, status: :ok, location: @service }
      else
        format.html { render :edit }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @project = @service.project
    @services = @project.services
    @service.destroy
    @service.project&.update_totals_project(@project)
    @service.project&.invoice&.update_totals_invoice(@service.project.invoice, @project.invoice.projects)
    respond_to do |format|
      format.js
      format.html { redirect_to request.env["HTTP_REFERER"], notice: t('service_destroy_success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_service
    @service = Service.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  def service_params
    params.require(:service).permit(:project_id, :total_gross, :invoice_id,
                                    :customer_id, :quotation_id, :name, :comment,
                                    :hourly_rate, :coefficient, :date, :duration,
                                    :status, :tva_rate, :total_cost, :start_time,
                                    :end_time, :provider, :is_displacement,:show_desc_invoice, :show_desc_quote )
  end
end