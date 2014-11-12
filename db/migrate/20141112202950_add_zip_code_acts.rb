class AddZipCodeActs < ActiveRecord::Migration
  def change
    remove_column :activities, :region_code
    add_column :activities, :zip_code, :integer
  end
end
