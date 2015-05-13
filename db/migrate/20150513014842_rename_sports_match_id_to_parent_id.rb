class RenameSportsMatchIdToParentId < ActiveRecord::Migration
  def change
  	rename_column :sports_matches, :sports_match_id, :parent_id
  end
end
