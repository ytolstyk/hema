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

class Fighter < ActiveRecord::Base
  validates :first_name, :last_name, presence: true
  has_many :tournament_fighters
  has_many :tournaments,
    through: :tournament_fighters,
    source: :tournament
  has_many :match_fighters,
    class_name: 'MatchFighter',
    primary_key: :id,
    foreign_key: :fighter_id
  has_many :matches,
    through: :match_fighters,
    source: :match
end
