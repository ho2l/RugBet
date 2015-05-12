class AddGameToBets < ActiveRecord::Migration
  def change
    add_reference :bets, :game, index: true, foreign_key: true
  end
end
