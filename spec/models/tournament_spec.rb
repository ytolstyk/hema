require 'spec_helper'

describe Tournament do
  context "creating new tournament" do
    it "should validate empty fields" do
      tournament = Tournament.create
      tournament.errors.full_messages.length.should > 0
      # expect { Tournament.create }.to raise_error
      # expect { Tournament.create(name: 'test') }.to raise_error
      # expect { Tournament.create(name: 'test', event_id: 1) }.to raise_error
      # expect { Tournament.create(name: 'test', event_id: 1, weapon_type: 'wood') }.to be_valid
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
      tournament = Tournament.create(name: 'test', event_id: 1, weapon_type: 'wood')
      tournament.errors.full_messages.length.should == 0
    end
  end
end
