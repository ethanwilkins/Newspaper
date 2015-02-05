class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :company
      t.string :image
      t.integer :zip_code
      t.timestamps
    end
  end
end
