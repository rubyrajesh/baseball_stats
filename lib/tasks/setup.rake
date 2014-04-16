require 'csv'

desc 'sets up the project by running migration and populating sample data'
task :setup => :environment do                                   

  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["setup_sample_data"].invoke
end

desc 'Setup sample data'
task setup_sample_data: :environment do
  Rake.application.invoke_task("load_players_from_csv[players_bio.csv]")
  Rake.application.invoke_task("load_seasons_from_csv[batting_scores.csv]")
end

desc 'Load players'
task :load_players_from_csv, [:filename] => :environment do |t, args|
  puts "Loading Players from db/seed/#{args.filename}..."
  
  file = File.join(Rails.root, 'db', 'seed', args.filename)
  total_rows = 0
  failed_rows = 0
  CSV.foreach(file, headers: true) do |row|
    total_rows += 1
    begin
      Player.create(row.to_hash)
    rescue ActiveRecord::StatementInvalid
      failed_rows += 1
    end
  end
  puts "Player loading stats: "
  puts "total_rows #{total_rows}, failed_rows #{failed_rows}"
end

desc 'Load Seasons'
task :load_seasons_from_csv, [:filename] => :environment do |t, args|
  puts "Loading seasons from db/seed/#{args.filename}..."
  
  file = File.join(Rails.root, 'db', 'seed', args.filename)
  total_rows = 0
  failed_rows = 0
  CSV.foreach(file, headers: true) do |row|
    total_rows += 1
    begin
      hashed_row = row.to_hash
      player = Player.where(player_id: hashed_row["player_id"]).first
      Season.create(player_id: player.id, year: hashed_row["year"], league: hashed_row["league"], team: hashed_row["team"], 
                     at_bats: hashed_row["at_bats"], hits: hashed_row["hits"], doubles: hashed_row["doubles"], 
                     triples: hashed_row["triples"], home_runs: hashed_row["home_runs"], runs_batted_in: hashed_row["runs_batted_in"])
    rescue ActiveRecord::StatementInvalid
      failed_rows += 1
      puts "=======#{row.inspect}========"
    end
  end
  puts "total_rows #{total_rows}, failed_rows #{failed_rows}"
end
