# frozen_string_literal: true

class QuotationsController < ApplicationController
  before_action :set_quotation, only: %i[show edit update destroy]
  load_and_authorize_resource

  before_action :set_cache_headers

  # GET /quotations
  # GET /quotations.json
  def index
    @search = Quotation.order(date: :desc).ransack(params[:q])
    @quotations = @search.result(distinct: true).paginate(page: params[:page], per_page: 30)
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show
    @company = Company.first
    @quotation = scope.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: t('quotation') + "_#{@quotation.id}",
               page_size: 'A4',
               template: 'quotations/show.html.erb',
               layout: 'pdf.html',
               orientation: 'Portrait',
               encoding: 'utf8',
               lowquality: true,
               zoom: 1,
               dpi: 75,
               margin: { bottom: 20 },
               footer: {
                 html: {
                   template: 'layouts/pdf_footer.html.erb'
                 }
               }
      end
    end
  end

  # GET /quotations/new
  def new
    @quotation = Quotation.new
    respond_to(&:js)
  end

  def scope
    ::Quotation.all.includes(:project)
  end

  # GET /quotations/1/edit
  def edit; end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = Quotation.new(quotation_params)

    respond_to do |format|
      if @quotation.save
        @quotation.update_totals_quotation(@quotation)
        format.html { redirect_to quotations_url, notice: 'Quotation was successfully created.' }
        format.json { render :show, status: :created, location: @quotation }
      else
        format.html { render :new }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        @quotation.update_totals_quotation(@quotation)
        format.html { redirect_to quotations_url, notice: 'Quotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @quotation }
      else
        format.html { render :edit }
        format.json { render json: @quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_url, notice: 'Quotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = Time.now
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_quotation
    @quotation = Quotation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def quotation_params
    params.require(:quotation).permit(:date, :status, :total, :total_gross, :customer_id, :project_id)
  end

end
