class CreateLeaguesUsers < ActiveRecord::Migration
  def change
    create_join_table :leagues, :users do |t|
    	t.index :league_id
    	t.index :user_id
    end
  end
end
