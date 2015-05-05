json.array!(@games) do |game|
  json.extract! game, :id, :id, :description, :pool, :e1, :e2, :s1, :s2, :start, :end, :location
  json.url game_url(game, format: :json)
end
