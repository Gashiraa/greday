require "application_system_test_case"

class OilsTest < ApplicationSystemTestCase
  setup do
    @oil = oils(:one)
  end

  test "visiting the index" do
    visit oils_url
    assert_selector "h1", text: "Oils"
  end

  test "creating a Oil" do
    visit oils_url
    click_on "New Oil"

    fill_in "Category", with: @oil.category
    fill_in "Machine", with: @oil.machine_id
    fill_in "Quantity", with: @oil.quantity
    fill_in "Type", with: @oil.type
    click_on "Create Oil"

    assert_text "Oil was successfully created"
    click_on "Back"
  end

  test "updating a Oil" do
    visit oils_url
    click_on "Edit", match: :first

    fill_in "Category", with: @oil.category
    fill_in "Machine", with: @oil.machine_id
    fill_in "Quantity", with: @oil.quantity
    fill_in "Type", with: @oil.type
    click_on "Update Oil"

    assert_text "Oil was successfully updated"
    click_on "Back"
  end

  test "destroying a Oil" do
    visit oils_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Oil was successfully destroyed"
  end
end
