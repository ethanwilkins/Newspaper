class AddWinsToSportsTeams < ActiveRecord::Migration
  def change
    add_column :sports_teams, :wins, :integer
    add_column :sports_teams, :losses, :integer
  end
end
