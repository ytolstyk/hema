# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  match_id   :integer          not null
#  target     :string(255)
#  afterblow  :boolean          default(FALSE)
#  double_hit :boolean          default(FALSE)
#  penalty    :integer
#  fighter_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  seconds    :integer          not null
#  points     :integer
#

require 'spec_helper'

describe Exchange do
  context "create" do
    it "should validate match_id" do
      exchange = Exchange.create(afterblow: true, double_hit: true)
      exchange.errors.full_messages.length.should > 0
    end

    it "should validate afterblow" do
      exchange = Exchange.create(match_id: 1, double_hit: true)
      exchange.errors.full_messages.length.should > 0
    end

    it "should validate double_hit" do
      exchange = Exchange.create(afterblow: true, match_id: 1)
      exchange.errors.full_messages.length.should > 0
    end

    it "should create exchange if all fields present" do
      Exchange.any_instance.stub(:add_points)
      exchange = Exchange.create(afterblow: true, double_hit: true, match_id: 1, fighter_id: 1, seconds: 12)
      exchange.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "should belong to a match" do
      Exchange.reflect_on_association(:match).macro.should == :belongs_to
    end

    it "should belong to a fighter" do
      Exchange.reflect_on_association(:fighter).macro.should == :belongs_to
    end
  end
end
