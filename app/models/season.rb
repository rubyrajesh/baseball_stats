class Season < ActiveRecord::Base
  belongs_to :player
  after_save :update_player_season_average
  
  scope :for_years, ->(years) { where(year: years) }
  scope :for_league, ->(league) { where(league: league) }
  scope :for_team, ->(team) { where(team: team) }
  scope :for_player, ->(player) { where(player_id: player) }

  def batting_average
    (hits/total_at_bats.to_f)*100
  end

  def total_at_bats
    at_bats == 0 ? 1 : at_bats
  end

  def total_runs
    singles + non_singles
  end

  def slugging_percentage
    ((total_runs/total_at_bats.to_f)*100).round(2)
  end

  def self.most_home_runs(year, league)
    for_years(year).for_league(league).order("home_runs desc").first
  end

  def self.most_rbi(year, league)
    for_years(year).for_league(league).order("runs_batted_in desc").first
  end

  private
  def update_player_season_average
    PlayerSeasonAverage.update_player_average(self)
  end

  def singles
    hits - doubles - triples - home_runs
  end

  def non_singles
    doubles*2 + triples*3 + home_runs*4
  end
end
