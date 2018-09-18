json.extract! task, :id, :operation, :dataset_id, :datafile_id, :storage_root, :storage_key, :binary_name, :created_at, :updated_at
json.url task_url(task, format: :json)
