# == Schema Information
#
# Table name: matches
#
#  id            :integer          not null, primary key
#  fighter1      :integer          not null
#  fighter2      :integer          not null
#  tournament_id :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Matches < ActiveRecord::Base
  validates :fighter1, :fighter2, :tournament_id, presence: true
  belongs_to :tournament
  belongs_to :fighter1,
    class_name: 'Fighters',
    foreign_key: :fighter1,
    primary_key: :id
  belongs_to :fighter2,
    class_name: 'Fighters',
    foreign_key: :fighter2,
    primary_key: :id
  has_many :exchanges
end
