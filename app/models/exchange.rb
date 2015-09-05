# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  match_id   :integer          not null
#  target     :string(255)
#  afterblow  :boolean          default(FALSE)
#  double_hit :boolean          default(FALSE)
#  penalty    :integer
#  fighter_id :integer          not null
#  created_at :datetime
#  updated_at :datetime
#  seconds    :integer          not null
#  points     :integer
#

class Exchange < ActiveRecord::Base
  validates :match_id, :fighter_id, :seconds, presence: true
  belongs_to :match
  belongs_to :fighter

  before_create :add_points
  before_save :add_points

  def add_points
    scores = match.pool.tournament.scores
    self.points = scores.where(target: target).first.points
  end
end
