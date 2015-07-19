# == Schema Information
#
# Table name: fighters
#
#  id         :integer          not null, primary key
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#  school     :string(255)
#  gender     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Fighter do
  context "create" do
    it "should validate first name" do
      fighter = Fighter.create(last_name: 'tolstykh')
      fighter.errors.full_messages.length.should > 0
    end

    it "should validate last name" do
      fighter = Fighter.create(first_name: 'yuriy')
      fighter.errors.full_messages.length.should > 0
    end

    it "should validate first name and last name" do
      fighter = Fighter.create(first_name: 'yuriy', last_name: 'tolstykh')
      fighter.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "should have many tournament_fighters" do
      Fighter.reflect_on_association(:tournament_fighters).macro.should == :has_many
    end

    it "should have many tournaments" do
      Fighter.reflect_on_association(:tournaments).macro.should == :has_many
    end

    it "should have many match_fighters" do
      Fighter.reflect_on_association(:match_fighters).macro.should == :has_many
    end

    it "should have many matches" do
      Fighter.reflect_on_association(:matches).macro.should == :has_many
    end
  end
end