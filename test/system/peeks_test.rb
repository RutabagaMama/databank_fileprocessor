require "application_system_test_case"

class PeeksTest < ApplicationSystemTestCase
  setup do
    @peek = peeks(:one)
  end

  test "visiting the index" do
    visit peeks_url
    assert_selector "h1", text: "Peeks"
  end

  test "creating a Peek" do
    visit peeks_url
    click_on "New Peek"

    fill_in "Datafile", with: @peek.datafile_id
    fill_in "Peek Text", with: @peek.peek_text
    fill_in "Peek Type", with: @peek.peek_type
    fill_in "Task", with: @peek.task_id
    click_on "Create Peek"

    assert_text "Peek was successfully created"
    click_on "Back"
  end

  test "updating a Peek" do
    visit peeks_url
    click_on "Edit", match: :first

    fill_in "Datafile", with: @peek.datafile_id
    fill_in "Peek Text", with: @peek.peek_text
    fill_in "Peek Type", with: @peek.peek_type
    fill_in "Task", with: @peek.task_id
    click_on "Update Peek"

    assert_text "Peek was successfully updated"
    click_on "Back"
  end

  test "destroying a Peek" do
    visit peeks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Peek was successfully destroyed"
  end
end
