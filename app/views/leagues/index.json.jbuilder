json.array!(@leagues) do |league|
  json.extract! league, :id, :title, :description
  json.url league_url(league, format: :json)
end
