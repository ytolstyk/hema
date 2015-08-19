require 'spec_helper'

describe TournamentsController do
  before(:each) do
    @controller.stub(ensure_logged_in: true)
  end
  let(:tournament) { Tournament.create(name: 'test name', weapon_type: 'wood', event_id: 1) }

  [:show].each do |action|
    it "#{action} should render properly given the id" do
      get action, id: tournament.id
      response.status.should == 200
    end
  end
end