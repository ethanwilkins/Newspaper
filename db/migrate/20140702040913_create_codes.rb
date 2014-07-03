class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :code
      t.string :title
      t.string :image
      t.timestamps
    end
  end
end
