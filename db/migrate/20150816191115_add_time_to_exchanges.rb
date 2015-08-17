class AddTimeToExchanges < ActiveRecord::Migration
  def change
    add_column :exchanges, :seconds, :integer, null: false
  end
end
