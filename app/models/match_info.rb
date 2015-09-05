# == Schema Information
#
# Table name: match_infos
#
#  id              :integer          not null, primary key
#  match_id        :integer          not null
#  match_completed :boolean          default(FALSE)
#  match_started   :boolean          default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#

class MatchInfo < ActiveRecord::Base
  validates :match_id, presence: true

  belongs_to :match
end
