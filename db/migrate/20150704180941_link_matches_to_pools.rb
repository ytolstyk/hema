class LinkMatchesToPools < ActiveRecord::Migration
  def change
    remove_column :matches, :tournament_id
    add_column :matches, :pool_id, :string, null: false
    add_index :matches, :pool_id
  end
end
