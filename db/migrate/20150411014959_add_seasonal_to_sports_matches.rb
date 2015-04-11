class AddSeasonalToSportsMatches < ActiveRecord::Migration
  def change
    add_column :sports_matches, :seasonal, :boolean
  end
end
