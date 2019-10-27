class ExpenseAccountsController < ApplicationController
  before_action :set_expense_account, only: [:show, :edit, :update, :destroy]

  # GET /expense_accounts
  # GET /expense_accounts.json
  def index
    @expense_accounts = ExpenseAccount.all
  end

  # GET /expense_accounts/1
  # GET /expense_accounts/1.json
  def show
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
        format.html { redirect_to @expense_account, notice: 'Expense account was successfully created.' }
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
        format.html { redirect_to @expense_account, notice: 'Expense account was successfully updated.' }
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
      format.html { redirect_to expense_accounts_url, notice: 'Expense account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense_account
      @expense_account = ExpenseAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_account_params
      params.require(:expense_account).permit(:reverse_invoice, :invoice_id, :description, :total_gross, :total)
    end
end
