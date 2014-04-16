## Setting up machine

``` ruby
bundle install
#Load all players & batting scores into the database
rake setup
```

###Stats
Run the following rake tasks to see the stats 

```ruby
rake most_improved_batting_average
rake oakland_2007_slugging_percentage
rake triple_crown_winners
```

### Running tests

``` ruby
# to execute all tests
rake

# to execute tests in models
rake test:models

# running an individual test file
rake test test/models/player_test.rb
```

### Load new players & batting scores
Copy csv file to db/seed folder and run the corresponding rake task after replacing the csv_file_name
```ruby
rake load_players_from_csv[csv_file_name]
rake load_seasons_from_csv[csv_file_name]
```
