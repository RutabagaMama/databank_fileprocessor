require 'test_helper'

class MessageOutsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message_out = message_outs(:one)
  end

  test "should get index" do
    get message_outs_url
    assert_response :success
  end

  test "should get new" do
    get new_message_out_url
    assert_response :success
  end

  test "should create message_out" do
    assert_difference('MessageOut.count') do
      post message_outs_url, params: { message_out: { content: @message_out.content } }
    end

    assert_redirected_to message_out_url(MessageOut.last)
  end

  test "should show message_out" do
    get message_out_url(@message_out)
    assert_response :success
  end

  test "should get edit" do
    get edit_message_out_url(@message_out)
    assert_response :success
  end

  test "should update message_out" do
    patch message_out_url(@message_out), params: { message_out: { content: @message_out.content } }
    assert_redirected_to message_out_url(@message_out)
  end

  test "should destroy message_out" do
    assert_difference('MessageOut.count', -1) do
      delete message_out_url(@message_out)
    end

    assert_redirected_to message_outs_url
  end
end
