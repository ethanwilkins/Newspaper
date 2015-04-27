class RemoveDefaultFromTotalRounds < ActiveRecord::Migration
  def change
    change_column_default :tournaments, :total_rounds, nil
  end
end
