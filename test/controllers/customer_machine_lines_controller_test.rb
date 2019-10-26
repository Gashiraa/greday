require 'test_helper'

class CustomerMachineLinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer_machine_line = customer_machine_lines(:one)
  end

  test "should get index" do
    get customer_machine_lines_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_machine_line_url
    assert_response :success
  end

  test "should create customer_machine_line" do
    assert_difference('CustomerMachineLine.count') do
      post customer_machine_lines_url, params: { customer_machine_line: { customer_id: @customer_machine_line.customer_id, hours: @customer_machine_line.hours, km: @customer_machine_line.km, machine_id: @customer_machine_line.machine_id } }
    end

    assert_redirected_to customer_machine_line_url(CustomerMachineLine.last)
  end

  test "should show customer_machine_line" do
    get customer_machine_line_url(@customer_machine_line)
    assert_response :success
  end

  test "should get edit" do
    get edit_customer_machine_line_url(@customer_machine_line)
    assert_response :success
  end

  test "should update customer_machine_line" do
    patch customer_machine_line_url(@customer_machine_line), params: { customer_machine_line: { customer_id: @customer_machine_line.customer_id, hours: @customer_machine_line.hours, km: @customer_machine_line.km, machine_id: @customer_machine_line.machine_id } }
    assert_redirected_to customer_machine_line_url(@customer_machine_line)
  end

  test "should destroy customer_machine_line" do
    assert_difference('CustomerMachineLine.count', -1) do
      delete customer_machine_line_url(@customer_machine_line)
    end

    assert_redirected_to customer_machine_lines_url
  end
end
