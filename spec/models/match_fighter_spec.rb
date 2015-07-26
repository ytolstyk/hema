# == Schema Information
#
# Table name: match_fighters
#
#  id         :integer          not null, primary key
#  fighter_id :integer          not null
#  match_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe MatchFighter do
  context "validations" do
    before(:each) do
      MatchFighter.delete_all
    end

    it "should require fighter_id" do
      match_fighter = MatchFighter.create(match_id: 1)
      match_fighter.errors.full_messages.length.should > 0
    end

    it "should require match_id" do
      match_fighter = MatchFighter.create(fighter_id: 1)
      match_fighter.errors.full_messages.length.should > 0
    end

    it "should create match_fighter if required fields present" do
      match_fighter = MatchFighter.create(fighter_id: 1, match_id: 1)
      match_fighter.errors.full_messages.length.should == 0
    end

    it "should fail if match_id and fighter_id combination is not unique" do
      match_fighter = MatchFighter.create(fighter_id: 3, match_id: 3)
      match_fighter_with_errors = MatchFighter.create(fighter_id: 3, match_id: 3)
      match_fighter.errors.full_messages.length.should == 0
      match_fighter_with_errors.errors.full_messages.length.should > 0
    end
  end

  context "associations" do
    it "belongs to fighter" do
      MatchFighter.reflect_on_association(:fighter).macro.should == :belongs_to
    end

    it "belongs to match" do
      MatchFighter.reflect_on_association(:match).macro.should == :belongs_to
    end
  end
end