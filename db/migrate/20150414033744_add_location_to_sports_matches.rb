class AddLocationToSportsMatches < ActiveRecord::Migration
  def change
    add_column :sports_matches, :location, :text
    add_column :sports_matches, :date, :datetime
  end
end
