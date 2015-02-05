class RenameAds < ActiveRecord::Migration
  def change
    rename_table :ads, :adverts
  end
end
