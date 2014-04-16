class CreatePlayerSeasonAverages < ActiveRecord::Migration
  def change
    create_table :player_season_averages do |t|
      t.integer :player_id
      t.integer :year
      t.string :league
      t.float :average

      t.timestamps
    end
  end
end
