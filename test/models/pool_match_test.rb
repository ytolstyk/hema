# == Schema Information
#
# Table name: pool_matches
#
#  id         :integer          not null, primary key
#  pool_id    :integer          not null
#  match_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class PoolMatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
