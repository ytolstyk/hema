# == Schema Information
#
# Table name: pools
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  tournament_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Pool < ActiveRecord::Base
  validates :tournament_id, :name, presence: true
  belongs_to :tournament
  has_many :matches
  has_many :pool_fighters,
    class_name: 'PoolFighter',
    primary_key: :id,
    foreign_key: :pool_id
  has_many :fighters,
    through: :pool_fighters,
    source: :fighter

  DEFAULT_POOL = 'Unassigned'

  def remove_pool
    return if name == Pool::DEFAULT_POOL
    reassign_fighters Pool::DEFAULT_POOL
    pool_number = get_pool_number
    tournament = Tournament.find(tournament_id)
    tournament.pools.each do |pool|
      if pool.get_pool_number > pool_number
        pool.name_pool pool.get_pool_number - 1
      end
    end
    destroy
  end

  def reassign_fighters(pool_name)
    return if fighters.count == 0
    
    tournament = Tournament.find(tournament_id)
    new_pool = tournament.pools.find_by_name(pool_name)
    new_pool = tournament.pools.create(name: DEFAULT_POOL) if new_pool.nil?
    fighters.each do |fighter|
      new_pool.pool_fighters.create(fighter_id: fighter.id)
      fighters.delete(fighter)
    end
  end

  def remove_fighter(fighter_id)
    pool_fighters_to_delete = pool_fighters.where('fighter_id = ?', fighter_id)
    pool_fighters_to_delete.each do |pool_fighter|
      pool_fighter.destroy
    end
  end

  def add_fighter(fighter_id)
    pool_fighters.create(fighter_id: fighter_id)
    generate_match fighter_id
  end

  def generate_match(fighter_id)
    pool_fighters.each do |fighter|
      next if fighter_id.to_i == fighter.fighter_id.to_i
      match = matches.create
      match.match_fighters.create(fighter_id: fighter.fighter_id)
      match.match_fighters.create(fighter_id: fighter_id)
    end
  end

  def generate_matches
    matches_array = pool_fighters.combination(2).to_a
    matches_array.each do |fighter_pair|
      match = matches.create
      fighter_pair.each do |fighter|
        match.match_fighters.create(fighter_id: fighter.fighter_id)
      end
    end
  end

  def update_pool(fighter_list)
    fighters.each do |fighter_id|
      if !fighter_list.include? fighter_id
        remove_fighter fighter_id
      end
    end

    fighter_list.try(:each) do |fighter_id|
      if !fighters.include? fighter_id
        add_fighter fighter_id
      end
    end
  end

  def name_pool(new_pool_id)
    update(name: "Pool #{new_pool_id}")
  end
  
  def get_pool_number
    return -1 if name == Pool::DEFAULT_POOL
    name.split(' ').last.to_i
  end
end
