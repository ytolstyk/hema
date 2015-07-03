class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.integer :event_id, null: false
      t.string :gender
      t.string :material

      t.timestamps
    end

    add_index :tournaments, :name
    add_index :tournaments, :type
    add_index :tournaments, :gender
    add_index :tournaments, :event_id
    add_index :tournaments, :material
  end
end
