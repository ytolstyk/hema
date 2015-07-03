class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :tournament_id, null: false
      t.string :target, null: false
      t.integer :points, null: false

      t.timestamps
    end

    add_index :scores, :tournament_id
  end
end
