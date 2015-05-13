class AddSportsMatchIdToSportsMatches < ActiveRecord::Migration
  def change
    add_column :sports_matches, :sports_match_id, :integer
  end
end
