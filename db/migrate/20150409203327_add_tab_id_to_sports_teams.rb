class AddTabIdToSportsTeams < ActiveRecord::Migration
  def change
    add_column :sports_teams, :tab_id, :integer
    add_column :sports_matches, :tab_id, :integer
    add_column :tournaments, :tab_id, :integer
    
    add_column :sports_teams, :tournament_id, :integer
    add_column :sports_matches, :tournament_id, :integer
  end
end
