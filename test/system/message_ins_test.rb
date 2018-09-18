require "application_system_test_case"

class MessageInsTest < ApplicationSystemTestCase
  setup do
    @message_in = message_ins(:one)
  end

  test "visiting the index" do
    visit message_ins_url
    assert_selector "h1", text: "Message Ins"
  end

  test "creating a Message in" do
    visit message_ins_url
    click_on "New Message In"

    fill_in "Content", with: @message_in.content
    click_on "Create Message in"

    assert_text "Message in was successfully created"
    click_on "Back"
  end

  test "updating a Message in" do
    visit message_ins_url
    click_on "Edit", match: :first

    fill_in "Content", with: @message_in.content
    click_on "Update Message in"

    assert_text "Message in was successfully updated"
    click_on "Back"
  end

  test "destroying a Message in" do
    visit message_ins_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Message in was successfully destroyed"
  end
end
