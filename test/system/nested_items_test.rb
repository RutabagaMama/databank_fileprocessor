require "application_system_test_case"

class NestedItemsTest < ApplicationSystemTestCase
  setup do
    @nested_item = nested_items(:one)
  end

  test "visiting the index" do
    visit nested_items_url
    assert_selector "h1", text: "Nested Items"
  end

  test "creating a Nested item" do
    visit nested_items_url
    click_on "New Nested Item"

    fill_in "Datafile", with: @nested_item.datafile_id
    fill_in "Dataset", with: @nested_item.dataset_id
    fill_in "Is Directory", with: @nested_item.is_directory
    fill_in "Item Name", with: @nested_item.item_name
    fill_in "Item Path", with: @nested_item.item_path
    fill_in "Size", with: @nested_item.size
    fill_in "Task", with: @nested_item.task_id
    fill_in "Tmp Path", with: @nested_item.tmp_path
    click_on "Create Nested item"

    assert_text "Nested item was successfully created"
    click_on "Back"
  end

  test "updating a Nested item" do
    visit nested_items_url
    click_on "Edit", match: :first

    fill_in "Datafile", with: @nested_item.datafile_id
    fill_in "Dataset", with: @nested_item.dataset_id
    fill_in "Is Directory", with: @nested_item.is_directory
    fill_in "Item Name", with: @nested_item.item_name
    fill_in "Item Path", with: @nested_item.item_path
    fill_in "Size", with: @nested_item.size
    fill_in "Task", with: @nested_item.task_id
    fill_in "Tmp Path", with: @nested_item.tmp_path
    click_on "Update Nested item"

    assert_text "Nested item was successfully updated"
    click_on "Back"
  end

  test "destroying a Nested item" do
    visit nested_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Nested item was successfully destroyed"
  end
end
