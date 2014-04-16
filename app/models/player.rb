class Player < ActiveRecord::Base
  has_many :seasons

  def name
    full_name = first_name ? first_name + ' ' : ''
    full_name += last_name ? last_name : ''
    full_name.chop
  end 
  
  def self.team_players_in_year(team, year)
    player_ids = Season.for_team(team).for_years(year).collect(&:player_id)
    Player.where(id: player_ids)
  end
end
