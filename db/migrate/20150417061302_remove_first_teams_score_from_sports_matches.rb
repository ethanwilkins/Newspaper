class RemoveFirstTeamsScoreFromSportsMatches < ActiveRecord::Migration
  def change
    remove_column :sports_matches, :first_teams_score
    remove_column :sports_matches, :second_teams_score

    remove_column :sports_teams, :wins
    remove_column :sports_teams, :losses
    
    add_column :stats, :first_teams_score, :integer
    add_column :stats, :second_teams_score, :integer
  end
end
