class RankingController < ApplicationController
	def index
		@users = User.find_by_sql("SELECT u.username, b.points FROM users u JOIN bets b ON u.id=b.user_id ORDER BY b.points")
	end
end
