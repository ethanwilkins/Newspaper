class AddZipCodeToSubtabs < ActiveRecord::Migration
  def change
    add_column :subtabs, :zip_code, :integer
  end
end
