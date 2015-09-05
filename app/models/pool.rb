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
  has_many :matches, dependent: :destroy
  has_many :pool_fighters,
    class_name: 'PoolFighter',
    primary_key: :id,
    foreign_key: :pool_id,
    dependent: :destroy
  has_many :fighters,
    through: :pool_fighters,
    source: :fighter

  DEFAULT_POOL = 'Unassigned'

  def self.all_tournament_fighters(tournament_id)
    Pool.where(tournament_id: tournament_id).map(&:fighters).flatten
  end

  def remove_pool
    return if name == Pool::DEFAULT_POOL
    reassign_fighters Pool::DEFAULT_POOL
    pool_number = get_pool_number
    tournament.pools.each do |pool|
      if pool.get_pool_number > pool_number
        pool.name_pool pool.get_pool_number - 1
      end
    end

    destroy
  end

  def reassign_fighters(pool_name)
    return if fighters.count == 0
  
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
    if name != Pool::DEFAULT_POOL
      generate_match fighter_id
    end
  end

  def generate_match(fighter_id)
    pool_fighters.each do |fighter|
      next if fighter_id.to_i == fighter.fighter_id.to_i
      match = matches.create
      match.match_fighters.create(fighter_id: fighter.fighter_id)
      match.match_fighters.create(fighter_id: fighter_id)
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

  def add_or_create_fighter(tournament_id, first_name, last_name)
    fighter = Fighter.where(first_name: first_name, last_name: last_name)

    if fighter.empty?
      fighters.create(first_name: first_name, last_name: last_name)
      "#{first_name} #{last_name} created and added"
    else
      add_existing_fighter(tournament_id, fighter.first)
    end
  end

  def add_existing_fighter(tournament_id, fighter)
    if self.class.all_tournament_fighters(tournament_id).include?(fighter)
      "#{fighter.first_name} #{fighter.last_name} is already in the tournament"
    else
      pool_fighters.create(fighter_id: fighter.id)
      "#{fighter.first_name} #{fighter.last_name} added"
    end
  end
end
