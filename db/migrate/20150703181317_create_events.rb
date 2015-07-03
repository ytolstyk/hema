class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.date :date
      t.string :organizer
      t.string :location

      t.timestamps
    end
    
    add_index :events, :name
    add_index :events, :organizer
    add_index :events, :location
  end
end
