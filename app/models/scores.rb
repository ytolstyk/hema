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

class Scores < ActiveRecord::Base
end
