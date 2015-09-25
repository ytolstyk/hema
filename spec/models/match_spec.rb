# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  pool_id    :string(255)      not null
#  index      :integer
#

require 'spec_helper'

describe Match do
  context "create" do
    before(:each) do
      Match.any_instance.stub(:create_match_info)
      Match.any_instance.stub(:populate_index)
    end

    it "should validate pool_id" do
      match = Match.create
      match.errors.full_messages.length.should > 0
    end

    it "should create match if pool_id exists" do
      match = Match.create(pool_id: 1, index: 3)
      match.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "should belong to a pool" do
      Match.reflect_on_association(:pool).macro.should == :belongs_to
    end

    it "should have many exchanges" do
      Match.reflect_on_association(:exchanges).macro.should == :has_many
    end

    it "should have many match_fighters" do
      Match.reflect_on_association(:match_fighters).macro.should == :has_many
    end

    it "should have many fighters" do
      Match.reflect_on_association(:fighters).macro.should == :has_many
    end

    it "should have many fighters" do
      Match.reflect_on_association(:match_info).macro.should == :has_one
    end
  end
end
