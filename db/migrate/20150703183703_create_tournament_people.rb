class CreateTournamentPeople < ActiveRecord::Migration
  def change
    create_table :tournament_fighters do |t|
      t.integer :fighter_id
      t.integer :tournament_id

      t.timestamps
    end

    add_index :tournament_fighters, :fighter_id
    add_index :tournament_fighters, :tournament_id
  end
end
