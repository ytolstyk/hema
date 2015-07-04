class RemovePoolMatches < ActiveRecord::Migration
  def change
    drop_table :pool_matches
  end
end
