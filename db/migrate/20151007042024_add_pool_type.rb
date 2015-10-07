class AddPoolType < ActiveRecord::Migration
  def change
    add_column :pools, :pool_type, :string
  end
end
