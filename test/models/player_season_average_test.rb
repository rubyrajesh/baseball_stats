require 'test_helper'

class PlayerSeasonAverageTest < ActiveSupport::TestCase
  test "create when season data is saved" do
    assert_equal PlayerSeasonAverage.count, 0
    
    Season.create!(player_id: 1, year: 2010, at_bats: 20, hits: 15, doubles: 4, home_runs: 3,
                   league: 'AL', team: 'OAK')

    assert_equal PlayerSeasonAverage.count, 1
    assert_equal PlayerSeasonAverage.where(player_id: 1, year: 2010).size, 1                           
  end
  
  test "update when season data is changed" do
    season = Season.create!(player_id: 1, year: 2007, at_bats: 20, hits: 15, doubles: 4, home_runs: 3,
                   league: 'AL', team: 'OAK')
    assert_equal PlayerSeasonAverage.count, 1
    assert_equal PlayerSeasonAverage.where(player_id: 1).first.average, 75.0                           
    
    season.hits = 10
    season.save!

    assert_equal PlayerSeasonAverage.count, 1
    assert_equal PlayerSeasonAverage.where(player_id: 1).first.average, 50.0                           
  end
end
