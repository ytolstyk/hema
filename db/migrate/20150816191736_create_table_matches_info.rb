class CreateTableMatchesInfo < ActiveRecord::Migration
  def change
    create_table :match_infos do |t|
      t.integer :match_id, null: false
      t.integer :winner_id
      t.integer :total_seconds
      t.integer :winner_points
      t.integer :loser_points
      t.boolean :match_completed, default: false
      t.boolean :started, default: false

      t.timestamps
    end

    add_index :match_infos, :match_id
    add_index :match_infos, :winner_id
  end
end
