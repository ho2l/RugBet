class AddPassToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :pass, :integer
  end
end
