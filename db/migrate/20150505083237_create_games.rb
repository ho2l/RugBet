class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :identifiant
      t.text :description
      t.string :pool
      t.string :e1
      t.string :e2
      t.integer :s1
      t.integer :s2
      t.date :start
      t.date :end
      t.string :location

      t.timestamps null: false
    end
  end
end
