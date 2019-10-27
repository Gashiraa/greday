require "application_system_test_case"

class ExpenseAccountsTest < ApplicationSystemTestCase
  setup do
    @expense_account = expense_accounts(:one)
  end

  test "visiting the index" do
    visit expense_accounts_url
    assert_selector "h1", text: "Expense Accounts"
  end

  test "creating a Expense account" do
    visit expense_accounts_url
    click_on "New Expense Account"

    fill_in "Description", with: @expense_account.description
    fill_in "Invoice", with: @expense_account.invoice_id
    fill_in "Reverse invoice", with: @expense_account.reverse_invoice
    fill_in "Total", with: @expense_account.total
    fill_in "Total gross", with: @expense_account.total_gross
    click_on "Create Expense account"

    assert_text "Expense account was successfully created"
    click_on "Back"
  end

  test "updating a Expense account" do
    visit expense_accounts_url
    click_on "Edit", match: :first

    fill_in "Description", with: @expense_account.description
    fill_in "Invoice", with: @expense_account.invoice_id
    fill_in "Reverse invoice", with: @expense_account.reverse_invoice
    fill_in "Total", with: @expense_account.total
    fill_in "Total gross", with: @expense_account.total_gross
    click_on "Update Expense account"

    assert_text "Expense account was successfully updated"
    click_on "Back"
  end

  test "destroying a Expense account" do
    visit expense_accounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Expense account was successfully destroyed"
  end
end
