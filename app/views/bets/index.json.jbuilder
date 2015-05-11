json.array!(@bets) do |bet|
  json.extract! bet, :id, :id_game, :id_user, :s1, :s2, :points, :done
  json.url bet_url(bet, format: :json)
end
