require 'test_helper'

class HopTasksControllerTest < ActionController::TestCase
  setup do
    @hop = hops(:one)
    @hop_task = hop_tasks(:one)
  end

  test "should get index" do
    get :index, :hop_id => @hop
    assert_response :success
    assert_not_nil assigns(:hop_tasks)
  end

  test "should get new" do
    get :new, :hop_id => @hop
    assert_response :success
  end

  test "should create hop_task" do
    assert_difference('HopTask.count') do
      post :create, :hop_id => @hop, :hop_task => @hop_task.attributes
    end

    assert_redirected_to hop_hop_task_path(@hop, assigns(:hop_task))
  end

  test "should show hop_task" do
    get :show, :hop_id => @hop, :id => @hop_task.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :hop_id => @hop, :id => @hop_task.to_param
    assert_response :success
  end

  test "should update hop_task" do
    put :update, :hop_id => @hop, :id => @hop_task.to_param, :hop_task => @hop_task.attributes
    assert_redirected_to hop_hop_task_path(@hop, assigns(:hop_task))
  end

  test "should destroy hop_task" do
    assert_difference('HopTask.count', -1) do
      delete :destroy, :hop_id => @hop, :id => @hop_task.to_param
    end

    assert_redirected_to hop_hop_tasks_path(@hop)
  end
end
