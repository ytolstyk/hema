class ScoresTargetTournamentDualIndex < ActiveRecord::Migration
  def change
    add_index :scores, [:target, :tournament_id], unique: true
  end
end
