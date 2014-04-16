desc 'Most improved batting average from 2009 to 2010'
task most_improved_batting_average: :environment do
  puts 'Most improved batting average from 2009 to 2010'

  puts StatsService.player_with_most_improved_batting_average(2009, 2010)
end

desc "Slugging percentage for all Oakland A's in 2007"
task oakland_2007_slugging_percentage: :environment do
  puts "Slugging percentage for all Oakland A's in 2007" 

  players = Player.team_players_in_year('OAK', 2007).collect(&:id)
  Season.for_years(2007).where(player_id: players).includes(:player).each do |season|
    puts "#{season.player.name} => #{season.slugging_percentage}"
  end
end

desc "Triple Crown Winner for 'AL' & 'NL' leagues for 2011 & 2012"
task triple_crown_winners: :environment do
  puts "Triple Crown Winner for: "
  
  puts 'AL league in 2011'
  al_2011_stats_service = StatsService.new(2011, 'AL')
  puts al_2011_stats_service.triple_crown_winner

  puts 'NL league in 2011'
  nl_2011_stats_service = StatsService.new(2011, 'NL')
  puts nl_2011_stats_service.triple_crown_winner

  puts 'AL league in 2012'
  al_2012_stats_service = StatsService.new(2012, 'AL')
  puts al_2012_stats_service.triple_crown_winner

  puts 'NL league in 2012'
  nl_2012_stats_service = StatsService.new(2012, 'NL')
  puts nl_2012_stats_service.triple_crown_winner
end
