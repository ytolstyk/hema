class AddFighterToMatchInfo < ActiveRecord::Migration
  def change
    remove_column :match_infos, :winner_id
    remove_column :match_infos, :total_seconds
    remove_column :match_infos, :winner_points
    remove_column :match_infos, :loser_points
  end
end
