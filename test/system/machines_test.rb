require "application_system_test_case"

class MachinesTest < ApplicationSystemTestCase
  setup do
    @machine = machines(:one)
  end

  test "visiting the index" do
    visit machines_url
    assert_selector "h1", text: "Machines"
  end

  test "creating a Machine" do
    visit machines_url
    click_on "New Machine"

    fill_in "Brand", with: @machine.brand
    fill_in "Hours", with: @machine.hours
    fill_in "Km", with: @machine.km
    fill_in "Model", with: @machine.model
    fill_in "Year", with: @machine.year
    click_on "Create Machine"

    assert_text "Machine was successfully created"
    click_on "Back"
  end

  test "updating a Machine" do
    visit machines_url
    click_on "Edit", match: :first

    fill_in "Brand", with: @machine.brand
    fill_in "Hours", with: @machine.hours
    fill_in "Km", with: @machine.km
    fill_in "Model", with: @machine.model
    fill_in "Year", with: @machine.year
    click_on "Update Machine"

    assert_text "Machine was successfully updated"
    click_on "Back"
  end

  test "destroying a Machine" do
    visit machines_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Machine was successfully destroyed"
  end
end
