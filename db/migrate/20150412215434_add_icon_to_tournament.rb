class AddIconToTournament < ActiveRecord::Migration
  def change
    add_column :tournaments, :icon, :string
    add_column :sports_matches, :icon, :string
  end
end
