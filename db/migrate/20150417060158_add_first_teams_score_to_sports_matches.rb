class AddFirstTeamsScoreToSportsMatches < ActiveRecord::Migration
  def change
    add_column :sports_matches, :first_teams_score, :integer
    add_column :sports_matches, :second_teams_score, :integer
  end
end
