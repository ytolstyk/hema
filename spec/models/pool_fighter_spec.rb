# == Schema Information
#
# Table name: pool_fighters
#
#  id         :integer          not null, primary key
#  pool_id    :integer
#  fighter_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe PoolFighter do
  context "validations" do
    before(:each) do
      PoolFighter.delete_all
    end

    it "validates fighter_id" do
      pool_fighter = PoolFighter.create(pool_id: 1)
      pool_fighter.errors.full_messages.length.should > 0
    end

    it "validates pool_id" do
      pool_fighter = PoolFighter.create(fighter_id: 1)
      pool_fighter.errors.full_messages.length.should > 0
    end

    it "validates unique fighter-pool pairs" do
      pool_fighter = PoolFighter.create(pool_id: 1, fighter_id: 1)
      pool_fighter_with_errors = PoolFighter.create(pool_id: 1, fighter_id: 1)
      pool_fighter.errors.full_messages.length.should == 0
      pool_fighter_with_errors.errors.full_messages.length.should > 0
    end

    it "creates pool_fighter if all fields are present" do
      pool_fighter = PoolFighter.create(pool_id: 1, fighter_id: 1)
      pool_fighter.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "belongs to fighter" do
      PoolFighter.reflect_on_association(:fighter).macro.should == :belongs_to
    end

    it "belongs to pool" do
      PoolFighter.reflect_on_association(:pool).macro.should == :belongs_to
    end
  end
end