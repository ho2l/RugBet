class AddUserToBets < ActiveRecord::Migration
  def change
    add_reference :bets, :user, index: true, foreign_key: true
  end
end
