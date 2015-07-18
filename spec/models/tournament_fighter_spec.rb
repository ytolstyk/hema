# == Schema Information
#
# Table name: tournament_fighters
#
#  id            :integer          not null, primary key
#  fighter_id    :integer
#  tournament_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe TournamentFighter do
  context "validations" do
    before(:each) do
      TournamentFighter.all.each do |tournament_fighter|
        tournament_fighter.destroy
      end
    end

    it "validates fighter_id" do
      tournament_fighter = TournamentFighter.create(tournament_id: 1)
      tournament_fighter.errors.full_messages.length.should > 0
    end

    it "validates tournament_id" do
      tournament_fighter = TournamentFighter.create(fighter_id: 1)
      tournament_fighter.errors.full_messages.length.should > 0
    end

    it "validates uniqueness of tournament_id/fighter_id pair" do
      tournament_fighter = TournamentFighter.create(fighter_id: 1, tournament_id: 1)
      tournament_fighter_with_errors = TournamentFighter.create(fighter_id: 1, tournament_id: 1)
      tournament_fighter.errors.full_messages.length.should == 0
      tournament_fighter_with_errors.errors.full_messages.length.should > 0
    end

    it "creates tournament_fighter if required fields exist" do
      tournament_fighter = TournamentFighter.create(fighter_id: 1, tournament_id: 1)
      tournament_fighter.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "belongs to tournament" do
      TournamentFighter.reflect_on_association(:tournament).macro.should == :belongs_to
    end

    it "belongs to fighter" do
      TournamentFighter.reflect_on_association(:fighter).macro.should == :belongs_to
    end
  end
end