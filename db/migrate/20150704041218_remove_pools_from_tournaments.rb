class RemovePoolsFromTournaments < ActiveRecord::Migration
  def change
    remove_column :tournament_fighters, :pool
  end
end
