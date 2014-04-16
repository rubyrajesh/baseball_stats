## Setting up machine

``` ruby
bundle install
rake setup
bundle exec rails console
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

