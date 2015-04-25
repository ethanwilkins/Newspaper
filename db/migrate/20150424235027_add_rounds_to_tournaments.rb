class AddRoundsToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :rounds, :integer
  end
end
