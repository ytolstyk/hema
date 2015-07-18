# == Schema Information
#
# Table name: scores
#
#  id            :integer          not null, primary key
#  tournament_id :integer          not null
#  target        :string(255)      not null
#  points        :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Score do
  context "validations" do
    it "validates tournament_id" do
      score = Score.create(target: 'head', points: 4)
      score.errors.full_messages.length.should > 0
    end

    it "validates target" do
      score = Score.create(tournament_id: 1, points: 4)
      score.errors.full_messages.length.should > 0
    end

    it "validates points" do
      score = Score.create(target: 'head', tournament_id: 4)
      score.errors.full_messages.length.should > 0
    end

    it "creates score if all required fields exist" do
      score = Score.create(target: 'head', points: 4, tournament_id: 1)
      score.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "belongs to tournament" do
      Score.reflect_on_association(:tournament).macro.should == :belongs_to
    end
  end
end