class AddLatitudeToZips < ActiveRecord::Migration
  def change
    add_column :zips, :latitude, :float
    add_column :zips, :longitude, :float
  end
end
