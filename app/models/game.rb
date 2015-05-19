class Game < ActiveRecord::Base
	has_many :bets
	has_many :comments
end
