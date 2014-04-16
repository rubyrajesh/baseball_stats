class StatsService

  def initialize(year, league)
    @year   = year
    @league = league
  end

  def self.player_with_most_improved_batting_average(from_year, to_year)
    player_id = PlayerSeasonAverage.most_improved_in_years(from_year, to_year).player_id
    Player.find_by_id(player_id).name
  end

  def triple_crown_winner
    player = player_with_highest_batting_average
    if player == player_with_most_home_runs && player == player_with_most_rbi
      Player.find_by_id(player).name
    else
      'No Winner'
    end
  end
  
  def player_with_highest_batting_average
    PlayerSeasonAverage.where(player_id: eligible_players.collect(&:id)).for_years(@year).for_league(@league).desc.first.player_id
  end

  def player_with_most_home_runs
    Season.where(player_id: eligible_players.collect(&:id)).most_home_runs(@year, @league).player_id
  end
  
  def player_with_most_rbi
    Season.where(player_id: eligible_players.collect(&:id)).most_rbi(@year, @league).player_id
  end

  private
  def eligible_players
    Player.joins(:seasons)
          .where("seasons.year = ?", @year)
          .where("seasons.at_bats > ?", 399)
    #player  = Player.arel_table
    #seasons = Season.arel_table

    #players.join(seasons).on(seasons[:player_id].eq(players[:id]))
    #       .where(seasons[:year].eq(2012))
    #       .where(seasons[:at_bats].gt(399))
    #       .joins_sources
  end

end
