class AddIndexToMatches < ActiveRecord::Migration
  def change
  	add_column :matches, :index, :integer, null: false
  end
end
