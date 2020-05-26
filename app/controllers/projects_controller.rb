# frozen_string_literal: true

class ProjectsController < ApplicationController

  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_company

  load_and_authorize_resource

  def set_company
    Project.set_company(@company.short_name)
  end

  # GET /projects
  # GET /projects.json
  def index
    @search = Project.order(date: :desc).includes(:customer).ransack(params[:q])
    @total = @search.result(distinct: true).sum(:total_gross)
    @projects = @search.result(distinct: true).paginate(page: params[:page], per_page: 30)
  end

  # GET /projects/1
  # GET /projects/1.json

  def show
    @project = scope.find(params[:id])

    if @company.use_machines
      @machine = Machine.where(id: @project.machine_id).first
      @machine_history = MachineHistory.order(date: :asc).where(machine_id: @project.machine_id)
    end

    if @company.short_name == "Greday"
      show_greday
    elsif @company.short_name == "PLUSVIEW" || "Philippe Doutrewé"
      show_plusview
    end
  end

  def show_greday
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: t('quotation') + "_#{@project.id}",
               page_size: 'A4',
               template: 'projects/gescoop.html.haml',
               layout: 'pdf/gescoop',
               orientation: 'Portrait',
               encoding: 'utf8',
               lowquality: true,
               zoom: 1,
               dpi: 75,
               :margin => {:bottom => 23, :top => 15, :left => 15, :right => 15},
               footer: {
                   html: {
                       template: 'layouts/pdf/greday_footer.html.erb'
                   },
               }
      end
    end
  end

  def show_plusview
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @company.name.downcase + "-devis" + @project.id.to_s,
               page_size: 'A4',
               template: 'projects/gescoop.html.haml',
               layout: 'pdf/gescoop',
               encoding: 'utf8',
               show_as_html: params.key?('debug'),
               :margin => {:bottom => 23, :top => 15, :left => 15, :right => 15},
               footer: {
                   html: {
                       template: 'layouts/pdf/quote/plusview_footer.html.erb'
                   },
               }
      end
    end
  end

  def duplicate
    respond_to do |format|
      @clone = @project.dup
      @clone.status = 0
      @clone.date = Date.today
      @clone.invoice_id = nil
      @project.project_extra_lines.each do |project_extra_lines|
        @clone.project_extra_lines.push(project_extra_lines.dup)
      end
      @project.services.each do |services|
        @clone.services.push(services.dup)
      end
      @project.wares.each do |wares|
        @clone.wares.push(wares.dup)
      end

      if @clone.save!
        format.html { redirect_to project_path(@clone), notice: t('project_update_success') }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    respond_to(&:js)
  end

  def scope
    ::Project.all
  end

  # GET /projects/1/edit
  def edit;
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects, @project.invoice.wares)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_add_success') }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects, @project.invoice.wares)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_update_success') }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_destroy_success') }
      format.json { head :no_content }
    end
  end

  def bin
    respond_to do |format|
      if @project.update(status: 5)
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects, @project.invoice.wares)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('project_update_success') }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def totals_project_once
    @once_projects = Project.all
    @once_projects.each do |project|
      project.update_totals_project(project)
    end
  end


  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = Time.now
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:invoice_id, :quotation_id, :customer_id,
                                    :name, :status, :wielding, :machining,
                                    :karcher, :total, :total_gross, :date,
                                    :description, :no_vat, :machine_id, :po, :applicant,
                                    :comment)
  end

end