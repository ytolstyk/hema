# == Schema Information
#
# Table name: scores
#
#  id            :integer          not null, primary key
#  tournament_id :integer          not null
#  target        :string(255)      not null
#  points        :integer          not null
#  created_at    :datetime
#  updated_at    :datetime
#

class Score < ActiveRecord::Base
  validates :tournament_id, :target, :points, presence: true
  validates_uniqueness_of :target, scope: :tournament_id
  belongs_to :tournament, dependent: :destroy
end
