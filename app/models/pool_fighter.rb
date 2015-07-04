# == Schema Information
#
# Table name: pool_fighters
#
#  id         :integer          not null, primary key
#  pool_id    :integer
#  fighter_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class PoolFighter < ActiveRecord::Base
end
