class AddSportsTeamIdToStats < ActiveRecord::Migration
  def change
  	add_column :stats, :sports_team_id, :integer
  	add_column :stats, :sports_match_id, :integer
  	add_column :stats, :tournament_id, :integer
  end
end
