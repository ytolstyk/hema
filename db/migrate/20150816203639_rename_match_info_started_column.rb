class RenameMatchInfoStartedColumn < ActiveRecord::Migration
  def change
    rename_column :match_infos, :started, :match_started
  end
end
