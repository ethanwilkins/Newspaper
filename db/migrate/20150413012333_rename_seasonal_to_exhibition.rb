class RenameSeasonalToExhibition < ActiveRecord::Migration
  def change
  	rename_column :sports_matches, :seasonal, :exhibition
  end
end
