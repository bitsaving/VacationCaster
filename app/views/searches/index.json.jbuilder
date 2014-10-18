json.array!(@searches) do |search|
  json.extract! search, :id, :options, :name, :slug, :start_date, :end_date, :user_id
  json.url search_url(search, format: :json)
end
