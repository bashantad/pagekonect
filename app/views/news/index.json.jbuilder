json.array!(@faculties) do |faculty|
  json.extract! faculty, :id, :title, :description
  json.url faculty_url(faculty, format: :json)
end
