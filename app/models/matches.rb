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
end
