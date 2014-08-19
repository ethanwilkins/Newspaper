class AddZipCodeToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :zip_code, :integer
  end
end
