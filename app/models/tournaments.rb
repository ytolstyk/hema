# == Schema Information
#
# Table name: tournaments
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  type       :string(255)      not null
#  event_id   :integer          not null
#  gender     :string(255)
#  material   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Tournaments < ActiveRecord::Base
end
