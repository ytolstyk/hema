# == Schema Information
#
# Table name: tournament_fighters
#
#  id            :integer          not null, primary key
#  fighter_id    :integer
#  tournament_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class TournamentFighter < ActiveRecord::Base
  validates :fighter_id, :tournament_id, presence: true
  validates_uniqueness_of :fighter_id, scope: :tournament_id
  belongs_to :fighter
  belongs_to :tournament

  after_create :add_to_default_pool

  def add_to_default_pool
    tournament = Tournament.find(tournament_id)
    default_pool = tournament.pools.find_by_name('Unassigned')
    if !default_pool
      default_pool = tournament.pools.create(name: 'Unassigned')
    end
    default_pool.pool_fighters.create(fighter_id: fighter_id)
  end
end
