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
#  fighter_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Exchange < ActiveRecord::Base
  validates :match_id, :afterblow, :double_hit, presence: true
  belongs_to :match
end