require 'test_helper'

class SeasonTest < ActiveSupport::TestCase

  test "batting average when both at_bats and hits is zero" do
    season = Season.new
    assert_equal 0.0, season.batting_average
  end
   
  test "batting average when at_bats is not zero" do
    season = Season.new(hits: 20, at_bats: 40)
    assert_equal 50.0, season.batting_average
  end

  test "should calculate total_runs" do
    season = Season.new(hits: 20, doubles: 1, triples: 2, home_runs: 3, at_bats: 5)
    assert_equal 34, season.total_runs
  end

  test "should calculate slugging_percentage as total_runs/at_bats" do
    season = Season.new(hits: 20, doubles: 1, triples: 2, home_runs: 3, at_bats: 30)
    assert_equal 113.33, season.slugging_percentage
  end

  test "most home runs season in year" do
    aaroha  = players(:aaroha)
    aaronto = players(:aaronto)   
 
    aaroha_2007  = FactoryGirl.create(:season, player_id: aaroha.id, team: 'OAK', year: 2007, home_runs: 10, league: 'AL')
    aaronto_2007 = FactoryGirl.create(:season, player_id: aaronto.id, team: 'SEA', year: 2007, home_runs: 15, league: 'AL')

    assert_equal aaronto_2007.id, Season.most_home_runs(2007, 'AL').id
  end
end
