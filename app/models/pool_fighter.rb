# == Schema Information
#
# Table name: pool_fighters
#
#  id         :integer          not null, primary key
#  pool_id    :integer          not null
#  fighter_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class PoolFighter < ActiveRecord::Base
end
