# == Schema Information
#
# Table name: pools
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  tournament_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Pool < ActiveRecord::Base
  validates :tournament_id, presence: true
  belongs_to :tournament
  has_many :matches
  has_many :pool_fighters,
    class_name: 'PoolFighter',
    primary_key: :id,
    foreign_key: :pool_id
  has_many :fighters,
    through: :pool_fighters,
    source: :fighter
end
