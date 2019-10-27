class CustomerMachineLinesController < ApplicationController
  before_action :set_customer_machine_line, only: [:show, :edit, :update, :destroy]

  # GET /customer_machine_lines
  # GET /customer_machine_lines.json
  def index
    @customer_machine_lines = CustomerMachineLine.all
  end

  # GET /customer_machine_lines/1
  # GET /customer_machine_lines/1.json
  def show
  end

  # GET /customer_machine_lines/new
  def new
    @customer_machine_line = CustomerMachineLine.new
  end

  # GET /customer_machine_lines/1/edit
  def edit
  end

  # POST /customer_machine_lines
  # POST /customer_machine_lines.json
  def create
    @customer_machine_line = CustomerMachineLine.new(customer_machine_line_params)

    respond_to do |format|
      if @customer_machine_line.save
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('machine_add_success')}
        format.json { render :show, status: :created, location: @customer_machine_line }
      else
        format.html { render :new }
        format.json { render json: @customer_machine_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_machine_lines/1
  # PATCH/PUT /customer_machine_lines/1.json
  def update
    respond_to do |format|
      if @customer_machine_line.update(customer_machine_line_params)
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('machine_update_success')}
        format.json { render :show, status: :ok, location: @customer_machine_line }
      else
        format.html { render :edit }
        format.json { render json: @customer_machine_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_machine_lines/1
  # DELETE /customer_machine_lines/1.json
  def destroy
    @customer_machine_line.destroy
    respond_to do |format|
      format.html {redirect_to request.env["HTTP_REFERER"], notice: t('machine_detroy_success')}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_machine_line
      @customer_machine_line = CustomerMachineLine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_machine_line_params
      params.require(:customer_machine_line).permit(:customer_id, :machine_id, :hours, :km)
    end
end
