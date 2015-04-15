class AddDateToTournaments < ActiveRecord::Migration
  def change
    add_column :tournaments, :date, :datetime
    add_column :tournaments, :location, :text
  end
end
