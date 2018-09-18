json.extract! nested_item, :id, :task_id, :dataset_id, :datafile_id, :tmp_path, :item_path, :item_name, :size, :is_directory, :created_at, :updated_at
json.url nested_item_url(nested_item, format: :json)
