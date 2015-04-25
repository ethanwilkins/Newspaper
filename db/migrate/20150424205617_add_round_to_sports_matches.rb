class AddRoundToSportsMatches < ActiveRecord::Migration
  def change
    add_column :sports_matches, :round, :integer
  end
end
