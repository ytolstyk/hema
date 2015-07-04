class ChangeTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :tournaments, :type, :weapon_type
  end
end
