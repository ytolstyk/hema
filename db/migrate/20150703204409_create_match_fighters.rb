class CreateMatchFighters < ActiveRecord::Migration
  def change
    create_table :match_fighters do |t|
      t.integer :fighter_id, null: false
      t.integer :match_id, null: false

      t.timestamps
    end

    add_index :match_fighters, :fighter_id
    add_index :match_fighters, :match_id
    add_index :match_fighters, [:fighter_id, :match_id], unique: true
    add_index :tournament_fighters, [:fighter_id, :tournament_id], unique: true
    remove_column :matches, :fighter1
    remove_column :matches, :fighter2
  end
end
