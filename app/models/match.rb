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
    match_info.create
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
end
