require 'test_helper'

class MessageInsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message_in = message_ins(:one)
  end

  test "should get index" do
    get message_ins_url
    assert_response :success
  end

  test "should get new" do
    get new_message_in_url
    assert_response :success
  end

  test "should create message_in" do
    assert_difference('MessageIn.count') do
      post message_ins_url, params: { message_in: { content: @message_in.content } }
    end

    assert_redirected_to message_in_url(MessageIn.last)
  end

  test "should show message_in" do
    get message_in_url(@message_in)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_in_url(@message_in)
    assert_response :success
  end

  test "should update message_in" do
    patch message_in_url(@message_in), params: { message_in: { content: @message_in.content } }
    assert_redirected_to message_in_url(@message_in)
  end

  test "should destroy message_in" do
    assert_difference('MessageIn.count', -1) do
      delete message_in_url(@message_in)
    end

    assert_redirected_to message_ins_url
  end
end
