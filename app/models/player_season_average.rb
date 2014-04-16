class PlayerSeasonAverage < ActiveRecord::Base
  
  belongs_to :player
  scope :for_years, ->(years) { where(year: years) }
  scope :for_league, ->(league) { where(league: league) }
  scope :desc, -> { order("average DESC") }

  def self.update_player_average(season)
    current_average = PlayerSeasonAverage.find_or_initialize_by(player_id: season.player_id, year: season.year, league: season.league)
    current_average.update(average: season.batting_average)     
  end

  def self.most_improved_in_years(from_year, to_year)
    PlayerSeasonAverage.joins("left outer join player_season_averages pba on player_season_averages.player_id = pba.player_id")
                       .where("pba.year = ?", to_year)
                       .where("player_season_averages.year = ?", from_year)
                       .select("pba.player_id, pba.average - player_season_averages.average as diff_average")
                       .order("diff_average desc")
                       .first
  end

end
