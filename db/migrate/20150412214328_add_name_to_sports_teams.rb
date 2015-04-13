class AddNameToSportsTeams < ActiveRecord::Migration
  def change
    add_column :sports_teams, :name, :text
    add_column :sports_teams, :icon, :string
  end
end
