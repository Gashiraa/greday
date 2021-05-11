# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_company
  require 'date'

  load_and_authorize_resource

  def set_company
    Project.set_company(@company.short_name)
  end

  # GET /projects
  # GET /projects.json
  def index
    respond_to do |format|
      format.html
      @search = Project.order(created_at: :desc).includes(:customer).ransack(params[:q])
      @total = @search.result(distinct: true).sum(:total_gross)
      @projects = @search.result(distinct: true).paginate(page: params[:page], per_page: 30)
      format.pdf do
        @search = Project.order(date: :asc).ransack(params[:q])
        @projects = @search.result(distinct: true)
        @total_gross = @projects.sum(:total_gross)
        @total = @projects.sum(:total)

        render pdf: t('invoice_report'),
               page_size: 'A4',
               template: 'layouts/pdf/report/projects.html.haml',
               layout: 'pdf/layout',
               encoding: 'utf8',
               show_as_html: false,
               margin: { bottom: 15, top: 15, left: 15, right: 15 },
               footer: {
                 html: {
                   template: 'layouts/pdf/report/footer.html.erb'
                 }
               }
      end
    end
  end

  def refresh_content
    respond_to do |format|
      format.js
    end
  end

  # GET /projects/1
  # GET /projects/1.json

  def show
    @project = scope.find(params[:id])
    @one_project = true
    if params[:method] == 'label'
      print_label
      return true
    end

    @machine = @project.machine if @company.use_machines

    respond_to do |format|
      format.html
      format.pdf do
        case @company.mode
        when 'Plusview'
          render pdf: "#{@company.name.downcase}-devis#{@project.id}",
                 page_size: 'A4',
                 template: 'layouts/pdf/quote/template.html.haml',
                 layout: 'pdf/layout',
                 encoding: 'utf8',
                 show_as_html: params.key?('debug'),
                 margin: { bottom: 23, top: 15, left: 15, right: 15 },
                 footer: {
                   html: {
                     template: 'layouts/pdf/quote/plusview_footer.html.erb'
                   }
                 }
        when 'Greday'
          render pdf: "#{display_quote_id(@project.id)}_#{@project.customer.name.upcase.tr(' ', '_')}_#{@project.name
                                                                                                .upcase.tr(' ', '_')}",
                 page_size: 'A4',
                 template: 'layouts/pdf/quote/template.html.haml',
                 layout: 'pdf/layout',
                 orientation: 'Portrait',
                 encoding: 'utf8',
                 show_as_html: params.key?('debug'),
                 zoom: 1,
                 dpi: 75,
                 margin: { bottom: 23, top: 15, left: 15, right: 15 },
                 footer: {
                   html: {
                     template: 'layouts/pdf/quote/greday_footer.html.erb'
                   }
                 }
        else
          #empty
        end
      end
    end
  end

  def print_label
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: t('quotation') + "_#{@project.id}",
               page_size: nil,
               page_height: '3.6cm',
               page_width: '8.9cm',
               template: 'layouts/pdf/label/template.html.haml',
               layout: 'pdf/layout',
               orientation: 'Portrait',
               encoding: 'utf8',
               margin: { bottom: 4, top: 4, left: 4, right: 4 },
               show_as_html: params.key?('debug'),
               dpi: 300
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
  def edit; end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects)
        @project.update_totals_project(@project)
        format.html { redirect_to request.env['HTTP_REFERER'], notice: t('project_add_success') }
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
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects)
        @project.update_totals_project(@project)
        format.html { redirect_to request.env['HTTP_REFERER'], notice: t('project_update_success') }
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
      format.html { redirect_to request.env['HTTP_REFERER'], notice: t('project_destroy_success') }
      format.json { head :no_content }
    end
  end

  def bin
    respond_to do |format|
      if @project.update(status: 6)
        @project.invoice&.update_totals_invoice(@project.invoice, @project.invoice.projects)
        format.html { redirect_to request.env['HTTP_REFERER'], notice: t('project_update_success') }
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
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = Time.now
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
                                    :comment, :services_recap, :services_recap_text, :displacement_recap,
                                    :machine_history, :hide_services_hours)
  end
end

