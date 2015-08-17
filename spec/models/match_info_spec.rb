# == Schema Information
#
# Table name: match_infos
#
#  id              :integer          not null, primary key
#  match_id        :integer          not null
#  match_completed :boolean          default(FALSE)
#  match_started   :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe MatchInfo do
  context "associations" do
    it "should belong to a pool" do
      MatchInfo.reflect_on_association(:match).macro.should == :belongs_to
    end
  end
end