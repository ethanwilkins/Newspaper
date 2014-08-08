class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :advertiser
      t.string :image
      t.integer :zip_code
      t.timestamps
    end
  end
end
