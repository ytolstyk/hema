class ExchangesAllowAfterblowNull < ActiveRecord::Migration
  def change
    change_column :exchanges, :afterblow, :boolean, null: true, default: false
    change_column :exchanges, :double_hit, :boolean, null: true, default: false
  end
end
