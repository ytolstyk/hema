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

class PoolMatch < ActiveRecord::Base
end
