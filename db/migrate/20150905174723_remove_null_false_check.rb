class RemoveNullFalseCheck < ActiveRecord::Migration
  def change
  	change_column :matches, :index, :integer, null: true
  end
end
