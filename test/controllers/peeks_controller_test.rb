require 'test_helper'

class PeeksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @peek = peeks(:one)
  end

  test "should get index" do
    get peeks_url
    assert_response :success
  end

  test "should get new" do
    get new_peek_url
    assert_response :success
  end

  test "should create peek" do
    assert_difference('Peek.count') do
      post peeks_url, params: { peek: { datafile_id: @peek.datafile_id, peek_text: @peek.peek_text, peek_type: @peek.peek_type, task_id: @peek.task_id } }
    end

    assert_redirected_to peek_url(Peek.last)
  end

  test "should show peek" do
    get peek_url(@peek)
    assert_response :success
  end

  test "should get edit" do
    get edit_peek_url(@peek)
    assert_response :success
  end

  test "should update peek" do
    patch peek_url(@peek), params: { peek: { datafile_id: @peek.datafile_id, peek_text: @peek.peek_text, peek_type: @peek.peek_type, task_id: @peek.task_id } }
    assert_redirected_to peek_url(@peek)
  end

  test "should destroy peek" do
    assert_difference('Peek.count', -1) do
      delete peek_url(@peek)
    end

    assert_redirected_to peeks_url
  end
end
