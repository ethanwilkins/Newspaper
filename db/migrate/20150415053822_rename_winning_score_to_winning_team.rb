class RenameWinningScoreToWinningTeam < ActiveRecord::Migration
  def change
    rename_column :stats, :winning_score, :winning_team_id
    rename_column :stats, :losing_score, :losing_team_id
  end
end
