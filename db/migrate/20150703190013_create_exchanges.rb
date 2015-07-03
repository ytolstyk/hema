class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.integer :match_id, null: false
      t.string :target
      t.boolean :afterblow, null: false
      t.boolean :double_hit, null: false
      t.integer :penalty
      t.integer :fighter_id

      t.timestamps
    end

    add_index :exchanges, :match_id
    add_index :exchanges, :fighter_id
  end
end
