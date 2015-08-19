# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  match_id   :integer          not null
#  target     :string(255)
#  afterblow  :boolean          not null
#  double_hit :boolean          not null
#  penalty    :integer
#  fighter_id :integer          not null
#  seconds    :integer          not null
#  points     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Exchange < ActiveRecord::Base
  validates :match_id, :fighter_id, :afterblow, :double_hit, :seconds, presence: true
  belongs_to :match

  before_create :fill_boolean_fields, :add_points
  before_save :fill_boolean_fields, :add_points

  def fill_boolean_fields
    self.afterblow ||= 'false'
    self.double_hit ||= 'false'
  end

  def add_points
    scores = match.pool.tournament.scores
    points = scores.where(target: target).first.points
  end
end
