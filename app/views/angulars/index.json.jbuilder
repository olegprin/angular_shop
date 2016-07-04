json.array!(@angulars) do |angular|
  json.extract! angular, :id, :title, :body
  json.url angular_url(angular, format: :json)
end
