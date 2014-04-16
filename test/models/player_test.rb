require 'test_helper'

class PlayerTest < ActiveSupport::TestCase

  test "should return proper name even if first_name is missing" do
    new_player = Player.create!(player_id: 'newpl01', first_name: 'John')
    assert_equal 'John', new_player.name 
  end

  test "should return players for team in a given year" do
    aaroha  = players(:aaroha)
    aaronto = players(:aaronto)   
    abadan  = players(:abadan)
 
    aaroha_2007  = FactoryGirl.create(:season, player_id: aaroha.id, team: 'OAK', year: 2007,)
    aaronto_2008 = FactoryGirl.create(:season, player_id: aaronto.id, team: 'SEA', year: 2007)
    abadan_2007  =  FactoryGirl.create(:season, player_id: abadan.id, team: 'OAK', year: 2008)

    assert_equal Player.team_players_in_year('OAK', 2007).collect(&:id).sort, [aaroha.id]
  end  
end
