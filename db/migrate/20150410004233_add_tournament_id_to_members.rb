class AddTournamentIdToMembers < ActiveRecord::Migration
  def change
    add_column :members, :tournament_id, :integer
    add_column :members, :sports_team_id, :integer
    add_column :members, :sports_match_id, :integer
  end
end
