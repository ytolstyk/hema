class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.string :name, null: false
      t.integer :tournament_id, null: false
      t.timestamps
    end
    add_index :pools, :tournament_id
  end
end
