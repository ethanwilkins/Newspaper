class DefaultToZeroForRounds < ActiveRecord::Migration
  def change
		change_column :tournaments, :total_rounds, :integer, default: 0
		change_column :tournaments, :current_round, :integer, default: 0
		
		rename_column :sports_matches, :current_round, :round
		change_column :sports_matches, :round, :integer, default: 0
  end
end
