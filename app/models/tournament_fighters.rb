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

class TournamentFighters < ActiveRecord::Base
  validates :fighter_id, :tournament_id, presence: true
  belongs_to :fighter
  belongs_to :tournament
end
