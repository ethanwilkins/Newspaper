class DropAds < ActiveRecord::Migration
  def change
    drop_table :advertisements
  end
end
