class AddZipCodeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :zip_code, :integer
  end
end
