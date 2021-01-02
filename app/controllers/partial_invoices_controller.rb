class PartialInvoicesController < ApplicationController
  before_action :set_partial_invoice, only: %i[show edit update destroy]

  load_and_authorize_resource

  def index
  end

  def new
    @partial_invoice = PartialInvoice.new
    respond_to(&:js)
  end

  def scope
    ::PartialInvoice.all
  end

  def edit; end

  def create
    @invoice = Invoice.new
    @invoice.status = 'created'
    @invoice.date = DateTime.current.to_date
    @invoice.display_number = get_next_invoice_number
    @invoice.customer_id = @partial_invoice.project.customer_id
    @invoice.save
    @partial_invoice = PartialInvoice.new(partial_invoice_params)
    @partial_invoice.invoice_id = @invoice.id
    respond_to do |format|
      if @partial_invoice.save
        @invoice.update_totals_invoice(@invoice, @invoice.projects)
        format.html { redirect_to invoice_path(@invoice.id, :format => :pdf), notice: t('partial_invoice_add_success') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @invoice = @partial_invoice.invoice
    @partial_invoice.invoice
    respond_to do |format|
      if @partial_invoice.update(partial_invoice_params)
        @invoice.update_totals_invoice(@invoice, @invoice.projects)
        format.html { redirect_to project_path(@partial_invoice.project), notice: t('partial_invoice_update_success') }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice = @partial_invoice.invoice
    @invoice.destroy
    @partial_invoice.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@partial_invoice.project), notice: t('partial_invoice_destroy_success') }
      format.json { head :no_content }
    end
  end

  private

  def set_partial_invoice
    @invoice = PartialInvoice.find(params[:id])
  end

  def partial_invoice_params
    params.require(:partial_invoice).permit(:amount, :pct, :project_id, :invoice_id, :comment)
  end

end