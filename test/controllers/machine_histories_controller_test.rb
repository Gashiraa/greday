require 'test_helper'

class MachineHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @machine_history = machine_histories(:one)
  end

  test "should get index" do
    get machine_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_machine_history_url
    assert_response :success
  end

  test "should create machine_history" do
    assert_difference('MachineHistory.count') do
      post machine_histories_url, params: { machine_history: { amout: @machine_history.amout, date: @machine_history.date, machine_id: @machine_history.machine_id } }
    end

    assert_redirected_to machine_history_url(MachineHistory.last)
  end

  test "should show machine_history" do
    get machine_history_url(@machine_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_machine_history_url(@machine_history)
    assert_response :success
  end

  test "should update machine_history" do
    patch machine_history_url(@machine_history), params: { machine_history: { amout: @machine_history.amout, date: @machine_history.date, machine_id: @machine_history.machine_id } }
    assert_redirected_to machine_history_url(@machine_history)
  end

  test "should destroy machine_history" do
    assert_difference('MachineHistory.count', -1) do
      delete machine_history_url(@machine_history)
    end

    assert_redirected_to machine_histories_url
  end
end
