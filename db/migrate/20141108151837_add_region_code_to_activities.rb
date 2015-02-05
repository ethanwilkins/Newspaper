class AddRegionCodeToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :region_code, :string
    add_column :activities, :city, :string
  end
end
