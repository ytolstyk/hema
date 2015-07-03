# == Schema Information
#
# Table name: matches
#
#  id            :integer          not null, primary key
#  tournament_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Matches < ActiveRecord::Base
  validates :tournament_id, presence: true
  belongs_to :tournament
  has_many :exchanges
end
