# frozen_string_literal: true

class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[show edit update destroy]

  load_and_authorize_resource

  # GET /invoices
  # GET /invoices.json
  def index
    respond_to do |format|
      format.html
      @search = Invoice.order(date: :desc).ransack(params[:q])
      @total = @search.result.sum(:total_gross)
      @invoices = @search.result(distinct: true).order(:status).paginate(page: params[:page], per_page: 30)
      format.pdf do
        @search = Invoice.order(date: :asc).ransack(params[:q])
        @invoices = @search.result(distinct: true)
        render pdf: t('invoice_report'),
               page_size: 'A4',
               template: 'layouts/pdf/report/invoices.html.haml',
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

  # GET /invoices/new
  def new
    @invoice = Invoice.new
    respond_to(&:js)
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = scope.find(params[:id])
    @one_project = (@invoice.projects.count == 1)
    @size = @invoice.get_size(@invoice)
    @tva_rates = @invoice.get_tva_rates(@invoice)
    @tva_amounts = []
    @tva_rates.each do |tva_rate|
      @tva_amounts.push(@invoice.get_tva_amounts(tva_rate, @invoice))
    end
    # show_gescoop
    case @company.mode
    when 'Greday'
      show_greday
    when 'Plusview'
      show_gescoop
    else
      # type code here
    end
  end

  def show_gescoop
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{@company.name.downcase}-facture#{@invoice.display_number}",
               page_size: 'A4',
               template: 'layouts/pdf/invoice/template.html.haml',
               layout: 'pdf/layout',
               encoding: 'utf8',
               show_as_html: params.key?('debug'),
               margin: { bottom: 23, top: 15, left: 15, right: 15 },
               footer: {
                 html: {
                   template: 'layouts/pdf/invoice/plusview_footer.html.erb'
                 }
               }
      end
    end
  end

  def show_greday
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "#{display_invoice_id(@invoice.display_number)}_#{@invoice.customer.name.upcase.tr(' ', '_')}",
               page_size: 'A4',
               template: 'layouts/pdf/invoice/template.html.haml',
               layout: 'pdf/layout',
               encoding: 'utf8',
               show_as_html: params.key?('debug'),
               dpi: 300,
               margin: { bottom: 20, top: 15, left: 15, right: 15 },
               footer: {
                 html: {
                   template: 'layouts/pdf/invoice/greday_footer.html.erb'
                 }
               }
      end
    end
  end

  def scope
    ::Invoice.all
  end

  # GET /invoices/1/edit
  def edit; end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.display_number = get_next_invoice_number if @company.use_manual_invoice_number == false
    respond_to do |format|
      if @invoice.save
        @invoice.update_statuses_invoice(@invoice, @company.short_name)
        @invoice.update_totals_invoice(@invoice, @invoice.projects)
        format.html { redirect_to invoice_path(@invoice.id, format: :pdf), notice: t('invoice_add_success') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        @invoice.update_statuses_invoice(@invoice, @company.short_name)
        @invoice.update_totals_invoice(@invoice, @invoice.projects)
        format.html { redirect_to invoices_url, notice: t('invoice_update_success') }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice.update_invoice_content_on_destroy(@invoice, @company.short_name)
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: t('invoice_destroy_success') }
      format.json { head :no_content }
    end
  end

  def paid
    respond_to do |format|
      if @invoice.update(status: 1)
        @invoice.update_statuses_invoice(@invoice, @company.short_name)
        format.html { redirect_to request.env['HTTP_REFERER'], notice: t('project_update_success') }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = Time.now
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def invoice_params
    params.require(:invoice).permit(:payment_id, :date, :status, :total, :display_number, :customer_id, :project_ids, project_ids: [])
  end
end
