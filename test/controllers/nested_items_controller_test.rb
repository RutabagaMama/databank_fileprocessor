require 'test_helper'

class NestedItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nested_item = nested_items(:one)
  end

  test "should get index" do
    get nested_items_url
    assert_response :success
  end

  test "should get new" do
    get new_nested_item_url
    assert_response :success
  end

  test "should create nested_item" do
    assert_difference('NestedItem.count') do
      post nested_items_url, params: { nested_item: { datafile_id: @nested_item.datafile_id, dataset_id: @nested_item.dataset_id, is_directory: @nested_item.is_directory, item_name: @nested_item.item_name, item_path: @nested_item.item_path, size: @nested_item.size, task_id: @nested_item.task_id, tmp_path: @nested_item.tmp_path } }
    end

    assert_redirected_to nested_item_url(NestedItem.last)
  end

  test "should show nested_item" do
    get nested_item_url(@nested_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_nested_item_url(@nested_item)
    assert_response :success
  end

  test "should update nested_item" do
    patch nested_item_url(@nested_item), params: { nested_item: { datafile_id: @nested_item.datafile_id, dataset_id: @nested_item.dataset_id, is_directory: @nested_item.is_directory, item_name: @nested_item.item_name, item_path: @nested_item.item_path, size: @nested_item.size, task_id: @nested_item.task_id, tmp_path: @nested_item.tmp_path } }
    assert_redirected_to nested_item_url(@nested_item)
  end

  test "should destroy nested_item" do
    assert_difference('NestedItem.count', -1) do
      delete nested_item_url(@nested_item)
    end

    assert_redirected_to nested_items_url
  end
end
