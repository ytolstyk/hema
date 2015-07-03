class AddMatchDurationToTournamentAndMaxScores < ActiveRecord::Migration
  def change
    add_column :tournaments, :duration, :integer
    add_column :tournaments, :victory_points, :integer
  end
end
