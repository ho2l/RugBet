class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :id_game
      t.integer :id_user
      t.integer :s1
      t.integer :s2
      t.integer :points
      t.boolean :done

      t.timestamps null: false
    end
  end
end
