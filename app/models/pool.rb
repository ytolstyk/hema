# == Schema Information
#
# Table name: pools
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  tournament_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Pool < ActiveRecord::Base
end
