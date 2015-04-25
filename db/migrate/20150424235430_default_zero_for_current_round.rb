class DefaultZeroForCurrentRound < ActiveRecord::Migration
  def change
  	rename_column :tournaments, :rounds, :total_rounds
  	rename_column :sports_matches, :round, :current_round
  end
end
