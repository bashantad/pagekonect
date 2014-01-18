json.array!(@uploads) do |upload|
  json.extract! upload, :id, :photo_tag, :photo_description, :user_id
  json.url upload_url(upload, format: :json)
end
