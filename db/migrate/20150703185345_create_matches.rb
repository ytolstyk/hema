class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :fighter1, null: false
      t.integer :fighter2, null: false
      t.integer :tournament_id, null: false

      t.timestamps
    end

    add_index :matches, :fighter1
    add_index :matches, :fighter2
    add_index :matches, :tournament_id
  end
end
