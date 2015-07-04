# == Schema Information
#
# Table name: match_fighters
#
#  id         :integer          not null, primary key
#  fighter_id :integer          not null
#  match_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class MatchFighter < ActiveRecord::Base
  validates :fighter_id, :match_id, presence: true
  validates_uniqueness_of :fighter_id, scope: :match_id
  belongs_to :fighter
  belongs_to :match
end
