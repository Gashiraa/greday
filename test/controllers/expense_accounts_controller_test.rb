require 'test_helper'

class ExpenseAccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @expense_account = expense_accounts(:one)
  end

  test "should get index" do
    get expense_accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_expense_account_url
    assert_response :success
  end

  test "should create expense_account" do
    assert_difference('ExpenseAccount.count') do
      post expense_accounts_url, params: { expense_account: { description: @expense_account.description, invoice_id: @expense_account.invoice_id, reverse_invoice: @expense_account.reverse_invoice, total: @expense_account.total, total_gross: @expense_account.total_gross } }
    end

    assert_redirected_to expense_account_url(ExpenseAccount.last)
  end

  test "should show expense_account" do
    get expense_account_url(@expense_account)
    assert_response :success
  end

  test "should get edit" do
    get edit_expense_account_url(@expense_account)
    assert_response :success
  end

  test "should update expense_account" do
    patch expense_account_url(@expense_account), params: { expense_account: { description: @expense_account.description, invoice_id: @expense_account.invoice_id, reverse_invoice: @expense_account.reverse_invoice, total: @expense_account.total, total_gross: @expense_account.total_gross } }
    assert_redirected_to expense_account_url(@expense_account)
  end

  test "should destroy expense_account" do
    assert_difference('ExpenseAccount.count', -1) do
      delete expense_account_url(@expense_account)
    end

    assert_redirected_to expense_accounts_url
  end
end
