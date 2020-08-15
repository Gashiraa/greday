class ExpenseAccountsController < ApplicationController
  before_action :set_expense_account, only: [:show, :edit, :update, :destroy]

  # GET /expense_accounts
  # GET /expense_accounts.json
  def index
    @search = ExpenseAccount.order(date: :desc).ransack(params[:q])
    @expense_accounts = @search.result(distinct: true).paginate(page: params[:page], per_page: 30)
  end

  # GET /expense_accounts/1
  # GET /expense_accounts/1.json
  def show
    @expense_account = scope.find(params[:id])
    @invoice = @expense_account.invoice
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: t('expense_accounts') + "_#{@expense_account.id}",
               page_size: 'A4',
               template: 'expense_accounts/show.html.erb',
               layout: 'pdf/layout',
               encoding: 'utf8',
               show_as_html: params.key?('debug'),
               :margin => {:bottom => 20},
               footer: {
                   html: {
                       template: 'layouts/pdf/invoice/greday_footer.html.erb'
                   },
               }
      end
    end
  end

  # GET /expense_accounts/new
  def new
    @expense_account = ExpenseAccount.new
  end

  # GET /expense_accounts/1/edit
  def edit
  end

  # POST /expense_accounts
  # POST /expense_accounts.json
  def create
    @expense_account = ExpenseAccount.new(expense_account_params)

    respond_to do |format|
      if @expense_account.save
        format.html { redirect_to expense_account_path(@expense_account.id, :format => :pdf), notice: t('expense_add_success') }
        format.json { render :show, status: :created, location: @expense_account }
      else
        format.html { render :new }
        format.json { render json: @expense_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expense_accounts/1
  # PATCH/PUT /expense_accounts/1.json
  def update
    respond_to do |format|
      if @expense_account.update(expense_account_params)
        format.html { redirect_to request.env["HTTP_REFERER"], notice: t('expense_update_success') }
        format.json { render :show, status: :ok, location: @expense_account }
      else
        format.html { render :edit }
        format.json { render json: @expense_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expense_accounts/1
  # DELETE /expense_accounts/1.json
  def destroy
    @expense_account.destroy
    respond_to do |format|
      format.html { redirect_to request.env["HTTP_REFERER"], notice: t('expense_destroy_success') }
      format.json { head :no_content }
    end
  end

  def scope
    ::ExpenseAccount.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense_account
    @expense_account = ExpenseAccount.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_account_params
    params.require(:expense_account).permit(:reverse_invoice, :invoice_id, :description, :total_gross, :total, :customer_id, :date)
  end
end
