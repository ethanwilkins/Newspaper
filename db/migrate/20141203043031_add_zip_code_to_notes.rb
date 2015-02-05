class AddZipCodeToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :zip_code, :integer
  end
end
