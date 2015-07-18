require 'spec_helper'

describe EventsController do
  before(:each) do
    @controller.stub(ensure_logged_in: true)
  end
  let(:event) { Event.create(name: 'test name') }

  [:index, :new].each do |action|
    it "#{action} should render properly" do
      get action
      response.status.should == 200
    end
  end

  [:show, :add_tournament].each do |action|
    it "#{action} should render properly given the id" do
      get action, id: event.id
      response.status.should == 200
    end
  end
end