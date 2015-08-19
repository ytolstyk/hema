class RemoveMatchFighters < ActiveRecord::Migration
  def change
    drop_table :tournament_fighters
  end
end
