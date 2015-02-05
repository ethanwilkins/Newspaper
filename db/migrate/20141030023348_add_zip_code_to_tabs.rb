class AddZipCodeToTabs < ActiveRecord::Migration
  def change
    add_column :tabs, :zip_code, :integer
  end
end
