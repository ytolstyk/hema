# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe User do
  context "validations" do
    before(:each) do
      User.all.each do |user|
        user.destroy
      end
    end

    it "validates username" do
      user = User.create(password: 'password')
      user.errors.full_messages.length.should > 0
    end

    it "validates password" do
      user = User.create(username: 'username')
      user.errors.full_messages.length.should > 0
    end

    it "valides length of password" do
      user = User.create(password: 'pass', username: 'username')
      user.errors.full_messages.length.should > 0
    end

    it "creates user with session token" do
      user = User.create(password: 'password', username: 'username')
      user.errors.full_messages.length.should == 0
    end
  end
end