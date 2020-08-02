require "application_system_test_case"

class WaresTest < ApplicationSystemTestCase
  setup do
    @ware = wares(:one)
  end

  test "visiting the index" do
    visit wares_url
    assert_selector "h1", text: "Wares"
  end

  test "creating a Ware" do
    visit wares_url
    click_on "New Ware"

    fill_in "Comment", with: @ware.comment
    fill_in "Customer", with: @ware.customer_id
    fill_in "Margin", with: @ware.margin
    fill_in "Name", with: @ware.name
    fill_in "Project", with: @ware.project_id
    fill_in "Provider discount", with: @ware.provider_discount
    fill_in "Quantity", with: @ware.quantity
    fill_in "Quotation", with: @ware.quotation_id
    fill_in "Status", with: @ware.status
    fill_in "Total cost", with: @ware.total_cost
    fill_in "Tva rate", with: @ware.tva_rate
    fill_in "Unit price", with: @ware.unit_price
    click_on "Create Ware"

    assert_text "Ware was successfully created"
    click_on "Back"
  end

  test "updating a Ware" do
    visit wares_url
    click_on "Edit", match: :first

    fill_in "Comment", with: @ware.comment
    fill_in "Customer", with: @ware.customer_id
    fill_in "Margin", with: @ware.margin
    fill_in "Name", with: @ware.name
    fill_in "Project", with: @ware.project_id
    fill_in "Provider discount", with: @ware.provider_discount
    fill_in "Quantity", with: @ware.quantity
    fill_in "Quotation", with: @ware.quotation_id
    fill_in "Status", with: @ware.status
    fill_in "Total cost", with: @ware.total_cost
    fill_in "Tva rate", with: @ware.tva_rate
    fill_in "Unit price", with: @ware.unit_price
    click_on "Update Ware"

    assert_text "Ware was successfully updated"
    click_on "Back"
  end

  test "destroying a Ware" do
    visit wares_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Ware was successfully destroyed"
  end
end
