require "application_system_test_case"

class MessageOutsTest < ApplicationSystemTestCase
  setup do
    @message_out = message_outs(:one)
  end

  test "visiting the index" do
    visit message_outs_url
    assert_selector "h1", text: "Message Outs"
  end

  test "creating a Message out" do
    visit message_outs_url
    click_on "New Message Out"

    fill_in "Content", with: @message_out.content
    click_on "Create Message out"

    assert_text "Message out was successfully created"
    click_on "Back"
  end

  test "updating a Message out" do
    visit message_outs_url
    click_on "Edit", match: :first

    fill_in "Content", with: @message_out.content
    click_on "Update Message out"

    assert_text "Message out was successfully updated"
    click_on "Back"
  end

  test "destroying a Message out" do
    visit message_outs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Message out was successfully destroyed"
  end
end
