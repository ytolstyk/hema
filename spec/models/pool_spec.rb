# == Schema Information
#
# Table name: pools
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  tournament_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#  pool_type     :string(255)
#

require 'spec_helper'

describe Pool do
  context "create" do
    it "should validate tournament_id" do
      pool = Pool.create
      pool.errors.full_messages.length.should > 0
    end

    it "should create a new pool with tournament_id" do
      pool = Pool.create(tournament_id: 1, name: 'test name')
      pool.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "should belong to a tournament" do
      Pool.reflect_on_association(:tournament).macro.should == :belongs_to
    end

    it "should have many matches" do
      Pool.reflect_on_association(:matches).macro.should == :has_many
    end

    it "should have many pool_fighters" do
      Pool.reflect_on_association(:pool_fighters).macro.should == :has_many
    end

    it "should have many fighters" do
      Pool.reflect_on_association(:fighters).macro.should == :has_many
    end
  end
end
