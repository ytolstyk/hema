# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  date       :date
#  organizer  :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Event do
  context "creating new event" do
    it "should validate name presence" do
      expect { Event.create }.to raise_error(NoMethodError)
    end

    it "should raise error if name is longer than 255 characters" do
      error = "Strings can't be longer than 255 characters"
      expect { Event.create(name: 'a' * 255) }.to raise_error(error)
      expect { Event.create(name: 'test', organizer: 'a' * 255) }.to raise_error(error)
      expect { Event.create(name: 'test', location: 'a' * 255) }.to raise_error(error)
    end

    it "should create event with just a name" do
      event = Event.create(name: 'test')
      event.errors.full_messages.length.should == 0
    end
  end

  context "associations" do
    it "should have tournaments" do
      Event.reflect_on_association(:tournaments).macro.should == :has_many
    end
  end
end