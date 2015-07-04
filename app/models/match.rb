# == Schema Information
#
# Table name: matches
#
#  id            :integer          not null, primary key
#  tournament_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Match < ActiveRecord::Base
  validates :tournament_id, presence: true
  belongs_to :tournament
  has_many :exchanges
  has_many :match_fighters,
    class_name: 'MatchFighter',
    primary_key: :id,
    foreign_key: :match_id
  has_many :fighters,
    through: :match_fighters,
    source: :fighter
end
