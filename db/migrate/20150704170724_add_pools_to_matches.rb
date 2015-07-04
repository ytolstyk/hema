class AddPoolsToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :pool_id, :integer, null: false
    remove_column :matches, :tournament_id
  end
end
