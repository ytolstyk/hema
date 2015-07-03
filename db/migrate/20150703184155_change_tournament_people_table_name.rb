class ChangeTournamentPeopleTableName < ActiveRecord::Migration
  def change
    rename_table :people, :fighters
  end
end
