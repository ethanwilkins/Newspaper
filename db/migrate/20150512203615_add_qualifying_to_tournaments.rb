class AddQualifyingToTournaments < ActiveRecord::Migration
  def change
  	add_column :tournaments, :qualifying, :boolean
  end
end
