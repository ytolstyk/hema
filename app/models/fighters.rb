# == Schema Information
#
# Table name: fighters
#
#  id         :integer          not null, primary key
#  first_name :string(255)      not null
#  last_name  :string(255)      not null
#  school     :string(255)
#  gender     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Fighters < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  has_many :tournament_fighters,
    class_name: 'TournamentFighters',
    primary_key: :id,
    foreign_key: :fighter_id
  has_many :tournaments,
    through: :tournament_fighters,
    source: :tournament
end
