class AddCurrentRoundToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :current_round, :integer
  end
end
