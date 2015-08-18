class AddColumnScoresToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :points, :integer
  end
end
