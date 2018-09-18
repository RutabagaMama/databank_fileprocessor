json.extract! message_out, :id, :content, :created_at, :updated_at
json.url message_out_url(message_out, format: :json)
