class RankingController < ApplicationController
	def index
		@users = User.find_by_sql("SELECT u.username, SUM(b.points) FROM users u JOIN bets b ON u.id=b.user_id GROUP BY u.username ORDER BY SUM(b.points);")
	end
end
