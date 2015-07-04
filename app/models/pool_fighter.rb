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
  validates :fighter_id, :pool_id, presence: true
  validates_uniqueness_of :fighter_id, scope: :pool_id
  belongs_to :fighter
  belongs_to :pool
end
