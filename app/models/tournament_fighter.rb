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
end
