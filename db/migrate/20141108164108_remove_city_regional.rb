class RemoveCityRegional < ActiveRecord::Migration
  def change
    remove_column :activities, :region_code
  end
end
