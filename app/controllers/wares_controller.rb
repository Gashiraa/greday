class WaresController < ApplicationController
  before_action :set_ware, only: %i[show edit update destroy]

  helper_method :sort_column, :sort_direction

  # GET /wares
  # GET /wares.json
  def index
    @search = Ware.paginate(page: params[:page], per_page: 12)
                  .joins('LEFT JOIN customers ON wares.customer_id = customers.id ')
                  .joins('LEFT JOIN projects ON wares.project_id = projects.id ')
                  .joins('LEFT JOIN customers AS c ON projects.customer_id = c.id')
                  .order(sort_column + " " + sort_direction)
                  .select('wares.id, wares.status, project_id, wares.customer_id, ware_name, comment,
                  provider_name, coalesce(c.name, customers.name)')
                  .ransack(params[:q])
                  @wares = @search.result(distinct: true)
  end

  # GET /wares/1
  # GET /wares/1.json
  def show;
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
        # update linked project
        @ware.project&.update_totals_project(@ware.project)

        # update linked invoice
        @ware.invoice&.update_totals_invoice(@ware.invoice, @ware.invoice.projects, @ware.invoice.wares)

        # update linked project's invoice
        @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects, @ware.project.invoice.wares)
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('ware_add_success')}
        format.json {render :show, status: :created, location: @ware}
      else
        format.html {render :new}
        format.json {render json: @ware.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /wares/1
  # PATCH/PUT /wares/1.json
  def update
    respond_to do |format|
      if @ware.update(ware_params)
        # update linked project
        @ware.project&.update_totals_project(@ware.project)

        # update linked invoice
        @ware.invoice&.update_totals_invoice(@ware.invoice, @ware.invoice.projects, @ware.invoice.wares)

        # update linked project's invoice
        @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects, @ware.project.invoice.wares)
        format.html {redirect_to request.env["HTTP_REFERER"], notice: t('ware_update_success')}
        format.json {render :show, status: :ok, location: @ware}
      else
        format.html {render :edit}
        format.json {render json: @ware.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /wares/1
  # DELETE /wares/1.json
  def destroy
    @ware.destroy
    # update linked project
    @ware.project&.update_totals_project(@ware.project)

    # update linked invoice
    @ware.invoice&.update_totals_invoice(@ware.invoice, @ware.invoice.projects, @ware.invoice.wares)

    # update linked project's invoice
    @ware.project&.invoice&.update_totals_invoice(@ware.project.invoice, @ware.project.invoice.projects, @ware.project.invoice.wares)
    respond_to do |format|
      format.html {redirect_to request.env["HTTP_REFERER"], notice: t('ware_destroy_success')}
      format.json {head :no_content}
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_ware
    @ware = Ware.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ware_params
    params.require(:ware).permit(:project_id, :invoice_id, :customer_id, :quotation_id, :name, :comment, :quantity, :margin, :provider_price, :bought_price, :status, :tva_rate, :total_cost, :total_gross, :provider_name, :provider_discount, :sell_price, :provider_invoice, :ware_name)
  end

  def sort_column
    if params[:sort] == "customers.name"
      "coalesce(c.name, customers.name)"
    else
      params[:sort] || "status"
    end
  end

  def sort_direction
      params[:direction] || "asc"
  end
end
