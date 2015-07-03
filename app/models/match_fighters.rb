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

class MatchFighters < ActiveRecord::Base
end
