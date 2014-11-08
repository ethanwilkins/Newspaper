class RemoveCityRegional < ActiveRecord::Migration
  def change
    remove_column :activities, :zip_code
    remove_column :activities, :city
    remove_column :activities, :region_code
  end
end
