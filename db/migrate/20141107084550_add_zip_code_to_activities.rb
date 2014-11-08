class AddZipCodeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :zip_code, :integer
  end
end
