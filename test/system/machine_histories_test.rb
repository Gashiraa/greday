require "application_system_test_case"

class MachineHistoriesTest < ApplicationSystemTestCase
  setup do
    @machine_history = machine_histories(:one)
  end

  test "visiting the index" do
    visit machine_histories_url
    assert_selector "h1", text: "Machine Histories"
  end

  test "creating a Machine history" do
    visit machine_histories_url
    click_on "New Machine History"

    fill_in "Amout", with: @machine_history.amout
    fill_in "Date", with: @machine_history.date
    fill_in "Machine", with: @machine_history.machine_id
    click_on "Create Machine history"

    assert_text "Machine history was successfully created"
    click_on "Back"
  end

  test "updating a Machine history" do
    visit machine_histories_url
    click_on "Edit", match: :first

    fill_in "Amout", with: @machine_history.amout
    fill_in "Date", with: @machine_history.date
    fill_in "Machine", with: @machine_history.machine_id
    click_on "Update Machine history"

    assert_text "Machine history was successfully updated"
    click_on "Back"
  end

  test "destroying a Machine history" do
    visit machine_histories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Machine history was successfully destroyed"
  end
end
