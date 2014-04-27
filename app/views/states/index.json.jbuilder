json.array!(@states) do |state|
  json.extract! state, :id, :country, :state
  json.url state_url(state, format: :json)
end
