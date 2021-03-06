class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /customers
  # GET /customers.json
  def index
    @search = Customer.ransack(params[:q])
    @customers = @search.result(distinct: true).order(:name).paginate(page: params[:page], per_page: 30)
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    respond_to(&:js)
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('customer_add_success')}
        format.json {render :show, status: :created, location: @customer}
      else
        format.html {render :new}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('customer_update_success')}
        format.json {render :show, status: :ok, location: @customer}
      else
        format.html {render :edit}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html {redirect_to request.env["HTTP_REFERER"], notice: t('customer_detroy_success')}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer
    @customer = Customer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def customer_params
    params.require(:customer).permit(:name, :mail, :tva_record, :street, :number, :cp, :locality,
                                     :country, :phone_number, :customer_rate, :subname)
  end
end
