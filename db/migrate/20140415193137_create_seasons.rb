class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :player_id,       null: false
      t.integer :year,            null: false
      t.string  :league,          null: false
      t.string  :team,            null: false
      t.integer :at_bats,         null: false, default: 0
      t.integer :hits,            null: false, default: 0
      t.integer :doubles,         null: false, default: 0
      t.integer :triples,         null: false, default: 0
      t.integer :home_runs,       null: false, default: 0
      t.integer :runs_batted_in,  null: false, default: 0

      t.timestamps
    end
    add_index :seasons, [:player_id, :team]
    add_index :seasons, [:player_id, :league]
    add_index :seasons, [:player_id, :year]
  end
end
