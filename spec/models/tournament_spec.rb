# == Schema Information
#
# Table name: tournaments
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  weapon_type    :string(255)      not null
#  event_id       :integer          not null
#  gender         :string(255)
#  material       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  duration       :integer
#  victory_points :integer
#

require 'spec_helper'

describe Tournament do
  context "creating new tournament" do
    it "should validate empty fields" do
      tournament = Tournament.create
      tournament.errors.full_messages.length.should > 0
    end

    it "should validate empty fields" do
      tournament = Tournament.create(name: 'test')
      tournament.errors.full_messages.length.should > 0
    end

    it "should validate empty fields" do
      tournament = Tournament.create(name: 'test', event_id: 1)
      tournament.errors.full_messages.length.should > 0
    end

    it "should create tournament if fields are valid" do
      tournament = Tournament.create(name: 'test', event_id: 1, weapon_type: 'longsword')
      tournament.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "should have scores" do
      Tournament.reflect_on_association(:scores).macro.should == :has_many
    end

    it "should have pools" do
      Tournament.reflect_on_association(:pools).macro.should == :has_many
    end
  end

  context "after_create behavior" do
    it "should have a default pool" do
      tournament = Tournament.create(name: 'test', event_id: 1, weapon_type: 'longsword')
      tournament.pools.pluck(:name).include?(Pool::DEFAULT_POOL).should == true
    end
  end
end
