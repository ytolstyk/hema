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
  validates :tournament_id, presence: true
  belongs_to :tournament
  has_many :matches
  has_many :pool_fighters,
    class_name: 'PoolFighter',
    primary_key: :id,
    foreign_key: :pool_id
  has_many :fighters,
    through: :pool_fighters,
    source: :fighter
  before_create :make_default_name

  def make_default_name
    self.name = "Pool #{tournament.pools.count + 1}"
  end

  def reassign_fighters(pool_name)
    tournament = Tournament.find(tournament_id)
    new_pool = tournament.pools.find_by_name(pool_name)
    self.fighters.each do |fighter|
      new_pool.pool_fighters.create(fighter_id: fighter.id)
      self.fighters.delete(fighter)
    end

  end

  def generate_matches
    matches_array = pool_fighters.combination(2).to_a
    matches_array.each do |fighter_pair|
      match = matches.create
      fighter_pair.each do |fighter|
        match.match_fighters.create(fighter_id: fighter)
      end
    end
  end
end
