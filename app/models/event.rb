# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  date       :date
#  organizer  :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Event < ActiveRecord::Base
  validates :name, presence: true
  has_many :tournaments
end