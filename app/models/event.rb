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
  validate :strings_shorter_than_255, before: [:create, :save, :update]
  has_many :tournaments

  private

  def strings_shorter_than_255
    if self.name.length > 254 || self.organizer.length > 254 || self.location.length > 254
      errors.add(:event, "strings can't be longer than 255 characters")
    end
  end
end
