# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  pool_id    :string(255)      not null
#

class Match < ActiveRecord::Base
  validates :pool_id, presence: true
  belongs_to :pool
  has_many :exchanges
  has_many :match_fighters,
    class_name: 'MatchFighter',
    primary_key: :id,
    foreign_key: :match_id,
    dependent: :destroy
  has_many :fighters,
    through: :match_fighters,
    source: :fighter
  has_one :match_info

  after_create :create_match_info

  def create_match_info
    MatchInfo.create(match_id: id)
  end

  def completed?
    match_info.match_completed
  end

  def started?
    match_info.match_started
  end

  def elapsed_time
    exchanges.pluck(:seconds).max
  end

  def update_match_info
    fighter_scores = Hash.new { |hash, key| hash[key] = 0 }

    exchanges.each do |exchange|
      fighter_scores[exchange.fighter_id] += exchange.points
    end

    update_match_completed(fighter_scores)
  end

  def update_match_completed(fighter_scores)
    max_seconds = pool.tournament.duration
    max_points = pool.tournament.victory_points
    points = fighter_scores.values

    if max_points && points.any? { |points| points >= max_points }
      match_info.update(match_completed: true)
    end

    if max_seconds && elapsed_time >= max_seconds && points.first != points.last
      match_info.update(match_completed: true)
    end
  end
end
