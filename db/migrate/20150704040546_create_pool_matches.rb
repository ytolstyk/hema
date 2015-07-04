class CreatePoolMatches < ActiveRecord::Migration
  def change
    create_table :pool_matches do |t|
      t.integer :pool_id, null: false
      t.integer :match_id, null: false
      t.timestamps
    end
    add_index :pool_matches, :pool_id
    add_index :pool_matches, :match_id
    add_index :pool_matches, [:pool_id, :match_id], unique: true
  end
end
