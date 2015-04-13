class RenameSportsTeamTournamentIdToMemberId < ActiveRecord::Migration
  def change
    rename_column :sports_teams, :tournament_id, :member_id
  end
end
