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
  validates :fighter_id, :pool_id, presence: true
  validates_uniqueness_of :fighter_id, scope: :pool_id

  belongs_to :fighter
  belongs_to :pool

  after_destroy :remove_matches

  def remove_matches
    matches = pool.matches.includes(:match_fighters).where(match_fighters: { fighter_id: fighter_id })
    matches.each do |match|
      match.destroy
    end  
  end
end
