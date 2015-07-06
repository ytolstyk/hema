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

describe Pool do
  describe '#generate_matches' do
    let(:pool) { Pool.create(name: "test_pool", tournament_id: 1) }

    before :each do
      pool.fighters.create(first_name: "AA", last_name: "AAA")
      pool.fighters.create(first_name: "BB", last_name: "BBB")
      pool.fighters.create(first_name: "CC", last_name: "CCC")
      pool.fighters.create(first_name: "DD", last_name: "DDD")
    end

    it 'should create six matches' do
      pool.generate_matches
      pool.matches.length.should == 6
    end

    it 'should create unique pairs' do
      pool.generate_matches
      sorted_matches = []
      pool.matches.each do |match|
        sorted_matches << match.match_fighters.sort
      end
      sorted_matches.should == sorted_matches.uniq
    end
  end
end
