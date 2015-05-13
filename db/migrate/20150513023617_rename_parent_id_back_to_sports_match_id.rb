class RenameParentIdBackToSportsMatchId < ActiveRecord::Migration
  def change
  	rename_column :sports_matches, :parent_id, :sports_match_id
  end
end
