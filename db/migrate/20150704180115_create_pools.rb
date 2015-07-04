class CreatePools < ActiveRecord::Migration
  def change
    create_table :pools do |t|
      t.string :name
      t.integer :tournament_id
      t.timestamps
    end
    add_index :pools, :tournament_id
  end
end
