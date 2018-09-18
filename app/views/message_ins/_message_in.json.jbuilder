json.extract! message_in, :id, :content, :created_at, :updated_at
json.url message_in_url(message_in, format: :json)
