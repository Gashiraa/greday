require "application_system_test_case"

class CustomerMachineLinesTest < ApplicationSystemTestCase
  setup do
    @customer_machine_line = customer_machine_lines(:one)
  end

  test "visiting the index" do
    visit customer_machine_lines_url
    assert_selector "h1", text: "Customer Machine Lines"
  end

  test "creating a Customer machine line" do
    visit customer_machine_lines_url
    click_on "New Customer Machine Line"

    fill_in "Customer", with: @customer_machine_line.customer_id
    fill_in "Hours", with: @customer_machine_line.hours
    fill_in "Km", with: @customer_machine_line.km
    fill_in "Machine", with: @customer_machine_line.machine_id
    click_on "Create Customer machine line"

    assert_text "Customer machine line was successfully created"
    click_on "Back"
  end

  test "updating a Customer machine line" do
    visit customer_machine_lines_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @customer_machine_line.customer_id
    fill_in "Hours", with: @customer_machine_line.hours
    fill_in "Km", with: @customer_machine_line.km
    fill_in "Machine", with: @customer_machine_line.machine_id
    click_on "Update Customer machine line"

    assert_text "Customer machine line was successfully updated"
    click_on "Back"
  end

  test "destroying a Customer machine line" do
    visit customer_machine_lines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Customer machine line was successfully destroyed"
  end
end
