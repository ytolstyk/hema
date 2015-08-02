class AddValidations < ActiveRecord::Migration
  def change
    change_column :pools, :tournament_id, :integer, :null => false
    change_column :pool_fighters, :pool_id, :integer, :null => false
    change_column :pool_fighters, :fighter_id, :integer, :null => false
    change_column :exchanges, :fighter_id, :integer, :null => false
  end
end
