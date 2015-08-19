# == Schema Information
#
# Table name: tournaments
#
#  id             :integer          not null, primary key
#  name           :string(255)      not null
#  weapon_type    :string(255)      not null
#  event_id       :integer          not null
#  gender         :string(255)
#  material       :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  duration       :integer
#  victory_points :integer
#

class Tournament < ActiveRecord::Base
  validates :event_id, :name, :weapon_type, presence: true
  belongs_to :event
  has_many :scores, dependent: :destroy
  has_many :pools, dependent: :destroy

  after_create :create_default_pool, :add_score

  def create_default_pool
    pools.create(name: Pool::DEFAULT_POOL)
  end

  def add_score
    scores.create(target: 'head', points: 4)
  end
end
