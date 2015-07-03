# == Schema Information
#
# Table name: tournaments
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  type           :string(255)      not null
#  event_id       :integer          not null
#  gender         :string(255)
#  material       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  duration       :integer
#  victory_points :integer
#

class Tournaments < ActiveRecord::Base
  validates :event_id, :name, :type, presence: true
  belongs_to :event
  has_many :scores, dependent: :destroy
  has_many :tournament_fighters,
    class_name: 'TournamentFighters',
    primary_key: :id,
    foreign_key: :tournament_id
  has_many :fighters,
    through: :tournament_fighters,
    source: :fighter
  has_many :matches, dependent: :destroy
end
