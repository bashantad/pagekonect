json.array!(@cities) do |city|
  json.extract! city, :id, :name, :state_id
  json.url city_url(city, format: :json)
end
