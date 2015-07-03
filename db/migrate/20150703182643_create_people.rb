class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :school
      t.string :gender

      t.timestamps
    end

    add_index :people, :last_name
    add_index :people, :school
    add_index :people, :gender
  end
end
