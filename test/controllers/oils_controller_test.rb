require 'test_helper'

class OilsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @oil = oils(:one)
  end

  test "should get index" do
    get oils_url
    assert_response :success
  end

  test "should get new" do
    get new_oil_url
    assert_response :success
  end

  test "should create oil" do
    assert_difference('Oil.count') do
      post oils_url, params: { oil: { category: @oil.category, machine_id: @oil.machine_id, quantity: @oil.quantity, type: @oil.type } }
    end

    assert_redirected_to oil_url(Oil.last)
  end

  test "should show oil" do
    get oil_url(@oil)
    assert_response :success
  end

  test "should get edit" do
    get edit_oil_url(@oil)
    assert_response :success
  end

  test "should update oil" do
    patch oil_url(@oil), params: { oil: { category: @oil.category, machine_id: @oil.machine_id, quantity: @oil.quantity, type: @oil.type } }
    assert_redirected_to oil_url(@oil)
  end

  test "should destroy oil" do
    assert_difference('Oil.count', -1) do
      delete oil_url(@oil)
    end

    assert_redirected_to oils_url
  end
end
