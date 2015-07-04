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
    foreign_key: :match_id
  has_many :fighters,
    through: :match_fighters,
    source: :fighter
end
