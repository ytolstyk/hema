# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  match_id   :integer          not null
#  target     :string(255)
#  afterblow  :boolean          not null
#  double_hit :boolean          not null
#  penalty    :integer
#  fighter_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
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
      exchange = Exchange.create(afterblow: true, double_hit: true, match_id: 1, fighter_id: 1)
      exchange.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "should belong to a match" do
      Exchange.reflect_on_association(:match).macro.should == :belongs_to
    end
  end
end
