require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Tasks"
  end

  test "creating a Task" do
    visit tasks_url
    click_on "New Task"

    fill_in "Binary Name", with: @task.binary_name
    fill_in "Datafile", with: @task.datafile_id
    fill_in "Dataset", with: @task.dataset_id
    fill_in "Operation", with: @task.operation
    fill_in "Storage Key", with: @task.storage_key
    fill_in "Storage Root", with: @task.storage_root
    click_on "Create Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "updating a Task" do
    visit tasks_url
    click_on "Edit", match: :first

    fill_in "Binary Name", with: @task.binary_name
    fill_in "Datafile", with: @task.datafile_id
    fill_in "Dataset", with: @task.dataset_id
    fill_in "Operation", with: @task.operation
    fill_in "Storage Key", with: @task.storage_key
    fill_in "Storage Root", with: @task.storage_root
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "destroying a Task" do
    visit tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task was successfully destroyed"
  end
end
