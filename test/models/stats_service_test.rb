require 'test_helper'

class StatsServiceTest < ActiveSupport::TestCase
    
  setup do
    @abadan  = players(:abadan)
    @aaroha  = players(:aaroha)
    @aaronto = players(:aaronto)
    abadan_2012_al  = FactoryGirl.create(:season, player: @abadan, at_bats: 420, hits: 90, doubles: 10, league: 'AL',
                                         triples: 8, home_runs: 22, runs_batted_in: 90, year: 2012)
    abadan_2012_nl  = FactoryGirl.create(:season, player: @abadan, at_bats: 420, hits: 90, doubles: 10, league: 'NL',
                                         triples: 8, home_runs: 10, runs_batted_in: 30, year: 2012)
    aaroha_2012_al  = FactoryGirl.create(:season, player: @aaroha, at_bats: 410, hits: 60, doubles: 20, league: 'AL',
                                         triples: 10, home_runs: 16, runs_batted_in: 75, year: 2012)
  end

  test "should return player with highest batting average in league" do
    @stats_service = StatsService.new(2012, 'AL')
    assert_equal @abadan.id, @stats_service.player_with_highest_batting_average
  end

  test "should return player with most home_runs" do
    @stats_service = StatsService.new(2012, 'AL')
    assert_equal @abadan.id, @stats_service.player_with_most_home_runs
  end

  test "should return player with most rbi" do
    aaronto_2012_nl =  FactoryGirl.create(:season, player: @aaronto, at_bats: 420, hits: 90, doubles: 10, league: 'NL',
                                           triples: 8, home_runs: 10, runs_batted_in: 90, year: 2012)
    @stats_service = StatsService.new(2012, 'NL')
    assert_equal @aaronto.id, @stats_service.player_with_most_rbi
  end

  test "should return triple crown winner if exists" do
    @stats_service = StatsService.new(2012, 'AL')
    assert_equal @abadan.name, @stats_service.triple_crown_winner
  end
  
  test "should return No Winner if there is no triple crown winner" do
    aaronto_2012_nl =  FactoryGirl.create(:season, player: @aaronto, at_bats: 440, hits: 90, doubles: 10, league: 'NL',
                                           triples: 8, home_runs: 15, runs_batted_in: 90, year: 2012)
    @stats_service = StatsService.new(2012, 'NL')
    assert_equal 'No Winner', @stats_service.triple_crown_winner
  end
end
