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
end
